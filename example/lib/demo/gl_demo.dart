
import 'package:wx_dart/wx_dart.dart';

import './gl/cube.dart';
import './gl/matrix4.dart';

// ------------------------- MyInfoPage ----------------------

class MyGLPage extends WxPanel {
  MyGLPage( WxWindow parent ) : super( parent, -1 )
  {
    final mainSizer = WxRow();
    setSizer( mainSizer );

    final attr = WxGLAttributes();
    attr.defaults();
    attr.doubleBuffer();
    attr.endList();
    final cubeWindow = MyCubeWindow(this, attr);
    mainSizer.add( cubeWindow, proportion: 1, flag: wxEXPAND|wxALL, border: 5 );

    final buttonSizer = WxColumn();
    mainSizer.addSizer(buttonSizer, flag: wxALIGN_BOTTOM );

    final upButton = WxButton(this, -1, "Up");
    upButton.bindButtonEvent( (_)=>cubeWindow.turnUp(), -1);
    buttonSizer.add( upButton, flag: wxALL, border: 5 );
    final downButton = WxButton(this, -1, "Down");
    downButton.bindButtonEvent( (_)=>cubeWindow.turnDown(), -1);
    buttonSizer.add( downButton, flag: wxALL, border: 5 );
    final leftButton = WxButton(this, -1, "Left");
    leftButton.bindButtonEvent( (_)=>cubeWindow.turnLeft(), -1);
    buttonSizer.add( leftButton, flag: wxALL, border: 5 );
    final rightButton = WxButton(this, -1, "Right");
    rightButton.bindButtonEvent( (_)=>cubeWindow.turnRight(), -1);
    buttonSizer.add( rightButton, flag: wxALL, border: 5 );
    buttonSizer.addSpacer(10);
  }

  int counter = 0;
}

// ----------------------- cube demo ---------------------------


abstract class MatrixContext extends WxGLContext {
  MatrixContext( super.canvas, super.attr ) {
    mvMatrix = Matrix4()..identity();
  }

  /// Perspective matrix
  late Matrix4 pMatrix;

  /// Model-View matrix.
  late Matrix4 mvMatrix;

  List<Matrix4> mvStack = <Matrix4>[];

  /// Add a copy of the current Model-View matrix to the the stack for future
  /// restoration.
  void mvPushMatrix() => mvStack.add( Matrix4.fromMatrix(mvMatrix) );

  /// Pop the last matrix off the stack and set the Model View matrix.
  void mvPopMatrix() => mvMatrix = mvStack.removeLast();
}

class CubeGLContext extends MatrixContext
{
  CubeGLContext( MyCubeWindow canvas, WxGLContextAttrs attrs ) : super( canvas, attrs )
  {
    _cubeWindow = canvas;
  }

  WxGlTexture? neheTexture;
  late MyCubeWindow _cubeWindow;
  late Cube cube;
  late WxGlProgram _glProgram;
  late WxGlUniformLocation _vertexLocation;
  late WxGlUniformLocation _textureLocation;
  late WxGlUniformLocation _uSamplerLocation;
  late WxGlUniformLocation _uPMatrixLocation;
  late WxGlUniformLocation _uMVMatrixLocation;
  late WxGlVertexArrayObject _vao;
  bool _dataLoaded = false;
  bool _onPrepareDone = false;
  double _xRot = 0;
  double _yRot = 20;
  double _zRot = 20;
  double _aspect = 1.0;

  void setViewport( int width, int height )
  {
    final gl = this;
    gl.viewport( 0, 0, width, height ); 
    _aspect = width / height;
    // wxLogStatus( wxTheApp.getTopWindow() as WxFrame, "OpenGL surface size: $width,$height" );
  }

  @override
  void onPrepare()
  {
    final gl = this;

    final version = gl.getString( gl.SHADING_LANGUAGE_VERSION );
    // print( "wxGlCanvas with GLSL version: $version" );
    wxLogStatus( wxTheApp.getTopWindow() as WxFrame, "wxGlCanvas with GLSL version: $version" );

    final versionString = version.contains("ES") ? "300 es" : "410";

    final vs = """#version $versionString
          in vec3 aVertexPosition;
          in vec2 aTextureCoord;

          uniform mat4 uMVMatrix;
          uniform mat4 uPMatrix;

          out vec2 vTextureCoord;

          void main(void) {
              gl_Position = uPMatrix * uMVMatrix * vec4(aVertexPosition, 1.0);
              vTextureCoord = aTextureCoord;
          }
""";

    final fs = """#version $versionString
          precision mediump float;
          out vec4 FragColor;

          in   vec2 vTextureCoord;

          uniform sampler2D uSampler;

          void main(void) {
              FragColor = texture(uSampler, vec2(vTextureCoord.s, vTextureCoord.t));
          }
    """;

    if (!initShaders(vs, fs)) {
      wxLogError( "Failed to create shaders" );
      return;
    }

    initVertices();

    _onPrepareDone = true;
    if (_dataLoaded) {
      _cubeWindow.updateCamera();
    }
  }

  void checkError( String operation )
  {
    final gl = this;
    final err = gl.getError();
    if (err != gl.NO_ERROR) {
      wxLogError( "$operation: error no: $err" );
    }
  }

  void initVertices()
  {
    final gl = this;

    checkError("before bindVertexArray" );

    _vao = gl.createVertexArray();
    gl.bindVertexArray( _vao );
    checkError("bindVertexArray" );

    cube = Cube( gl );

    wxLoadImageFromResource("horse.png", ((image)
    {
      // TODO: do we have to call these?
      // gl.bindVertexArray( _vao );
      // makeCurrent() 

      neheTexture = createTexture();
      gl.pixelStorei(gl.UNPACK_ALIGNMENT, 1);
      gl.bindTexture(gl.TEXTURE_2D, neheTexture! );
      checkError("bindTexture" );

      gl.texImage2D( gl.TEXTURE_2D, 0, gl.RGB, 200, 200, 0, gl.RGB, gl.UNSIGNED_BYTE, image.getData() );
      checkError("texImage2D" );

      gl.texParameteri(
          gl.TEXTURE_2D,
          gl.TEXTURE_MAG_FILTER,
          gl.NEAREST,
        );
      gl.texParameteri(
          gl.TEXTURE_2D,
          gl.TEXTURE_MIN_FILTER,
          gl.NEAREST,
        );
      gl.bindTexture(gl.TEXTURE_2D, null);
      checkError("bindTexture null" );
      _dataLoaded = true;

      if (_onPrepareDone) {
        _cubeWindow.updateCamera();
      }
    }) );

    _vertexLocation = gl.getAttribLocation( _glProgram, "aVertexPosition" );
    checkError("getAttribLocation" );
    gl.enableVertexAttribArray(_vertexLocation.getId());
    checkError("enableVertexAttribArray" );

    _textureLocation = gl.getAttribLocation( _glProgram, "aTextureCoord" );
    checkError("getAttribLocation" );
    gl.enableVertexAttribArray(_textureLocation.getId());
    checkError("enableVertexAttribArray" );

    _uSamplerLocation = gl.getUniformLocation(_glProgram, 'uSampler' );
    checkError("_uSamplerLocation = gl.getUniformLocation" );

    _uPMatrixLocation = gl.getUniformLocation(_glProgram, 'uPMatrix' );
    checkError("_uPMatrixLocation = gl.getUniformLocation" );

    _uMVMatrixLocation = gl.getUniformLocation(_glProgram, 'uMVMatrix' );
    checkError("_uMVMatrixLocation = gl.getUniformLocation" );
  }

  bool initShaders( String vsSource, String fsSource)
  {
    final gl = this;

    // empty the last error 
    gl.getError();

    // Compile vertex shader
    final vertexShader = gl.createShader(gl.VERTEX_SHADER);
    gl.shaderSource(vertexShader, vsSource);
    gl.compileShader(vertexShader);
    checkError("compile vertex shader" );
    // if (vertexShader.getId() < 1) {
    //   wxLogError( "vertexShader not compiled" );
    // }

    // Compile fragment shader
    final fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
    gl.shaderSource(fragmentShader, fsSource);
    gl.compileShader(fragmentShader);
    checkError("compile fragment shader" );
    // if (fragmentShader.getId() < 1) {
    //   wxLogError( "fragmentShader not compiled" );
    // }

    // Create program
    _glProgram = gl.createProgram();
    checkError("createProgram" );

    // Attach and link shaders to the program
    gl.attachShader(_glProgram, vertexShader);
    gl.attachShader(_glProgram, fragmentShader);
    gl.linkProgram(_glProgram);
    checkError("linkProgram" );

    // Use program
    // gl.useProgram(_glProgram);
    checkError("useProgram" );

    return true;
  }

  void render()
  {
    final gl = this;

    gl.bindVertexArray( _vao );
    checkError("bindVertexArray" );
    
    gl.useProgram(_glProgram);
    checkError("useProgram" );

    // Clear canvas
    gl.clearColor(0.2, 0.2, 0.2, 1.0);
    gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT );

    gl.enable(gl.DEPTH_TEST);
    gl.disable(gl.BLEND);
    // checkError("disable(gl.CULL_FACE" );

    if (!_dataLoaded) return;

    pMatrix = Matrix4.perspective(65.0, _aspect, 0.1, 100.0);

    // First stash the current model view matrix before we start moving around.
    mvPushMatrix();

    mvMatrix
      ..translate([0.0, 0.0, -5.0])
      ..rotateX(radians(_xRot))
      ..rotateY(radians(_yRot))
      ..rotateZ(radians(_zRot));

    gl.activeTexture(gl.TEXTURE0);
    checkError("activeTexture" );
    gl.bindTexture(gl.TEXTURE_2D, neheTexture);
    checkError("bindTexture" );
    gl.uniform1i( _uSamplerLocation, 0);
    checkError("uniform1i" );

    cube.draw(
        setUniforms: setMatrixUniforms,
        vertex: _vertexLocation.getId(),
        coord: _textureLocation.getId());

    mvPopMatrix();

    gl.flush();
  }

  void setMatrixUniforms() {
    final gl = this;
    gl.uniformMatrix4fv( _uPMatrixLocation, false, pMatrix.buf );
    gl.uniformMatrix4fv( _uMVMatrixLocation, false, mvMatrix.buf );
  }

  void turnLeft() {
    _yRot -= 5.0;
  }
  void turnRight() {
    _yRot += 5.0;
  }
  void turnUp() {
    _xRot -= 5.0;
  }
  void turnDown() {
    _xRot += 5.0;
  }

  void setXRot( double angle ) {
    _xRot = angle;
  }
  void setYRot( double angle ) {
    _yRot = angle;
  }
  void setZRot( double angle ) {
    _zRot = angle;
  }
}

class MyCubeWindow extends WxGLCanvas
{
  MyCubeWindow( WxPanel parent, WxGLAttributes attr ) : super( parent, attr, -1 )
  {
    _mainWindow = parent;

    final attrs = WxGLContextAttrs();
    attrs.forwardCompatible();
    attrs.coreProfile();
//     attrs.ES2();
    attrs.endList();
    _glContext = CubeGLContext(this,attrs);

    // bindSetFocusEvent( (_) => _mainWindow.setFocusToMapWindow() );

    bindSizeEvent( (_) => updateCamera() );
  }

  late CubeGLContext _glContext;

  void turnLeft() {
    _glContext.turnLeft();
    updateCamera();
  }
  void turnRight() {
    _glContext.turnRight();
    updateCamera();
  }
  void turnUp() {
    _glContext.turnUp();
    updateCamera();
  }
  void turnDown() {
    _glContext.turnDown();
    updateCamera();
  }


  void updateCamera()
  {
    setCurrent(_glContext);
    final size = getClientSize();
    _glContext.setViewport( size.x, size.y );

    _glContext.render();
    swapBuffers();
  }

  late WxPanel _mainWindow;
}
