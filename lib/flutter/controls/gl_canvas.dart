// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01
// Copyright:   (c) 2026 Robert Roebling
// Licence:     wxWindows licence
// ---------------------------------------------------------------------------

part of '../../wx_dart.dart';


// ------------------------- wxGLContextAttrs ----------------------

/// Helper class to set attributes for a [WxGLContext]
/// 
/// Not yet implemented fully in wxDart Flutter

class WxGLContextAttrs extends WxClass {
  WxGLContextAttrs();

  void oGLVersion( int major, int minor ) {
  }

  void coreProfile( ) {
  }

  void forwardCompatible( ) {
  }

  void ES2( ) {
  }

  void robust( ) {
  }

  void loseOnReset( ) {
  }

  void resetIsolation( ) {
  }

  void endList( ) {
  }
}

// ------------------------- wxGLContextAttrs ----------------------

/// Helper class to set attributes for a [WxGLCanvas]
/// 
/// Not yet implemented fully in wxDart Flutter

class WxGLAttributes extends WxClass {
  WxGLAttributes();

  void platformDefaults( ) {
  }

  void defaults( ) {
  }

  void doubleBuffer( ) {
  }

  void RGBA( ) {
  }

  void level( int val ) {
  }

  void bufferSize( int val ) {
  }

  void depth( int val ) {
  }

  void stencil( int val ) {
  }

  void sampleBuffers( int val ) {
  }

  void samplers( int val ) {
  }

  void endList( ) {
  }
}

// ------------------------- wxGLCanvas ----------------------

FlutterAngle? _flutterGlPlugin;

/// Represents an OpenGL/OpenGL ES/WebGL surface.
/// 
/// Use together with [WxGLContext].
/// 
/// Main interface
/// * [setCurrent]
/// * [swapBuffers]
/// 
/// Sample code:
///```dart
///   // in parent window's constructor
///   {
///     final attr = WxGLAttributes();
///     attr.defaults();
///     attr.doubleBuffer();
///     attr.endList();
///     _glCanvas = MyGLCanvas(this,attr);
///   }
///
/// class MyGLCanvas extends WxGLCanvas
/// {
///   MyGLCanvas( WxWindow parent, WxGLAttributes attr ) : super( parent, attr, -1 )
///   {
///     final attrs = WxGLContextAttrs();
///     // Use OpenGL 4.1 on macOS in wxDart Native
///     attrs.forwardCompatible();
///     attrs.coreProfile();
///     // attrs.ES2();
///     attrs.endList();
///     
///     // Create GL context
///     _glContext = MyGLContext(this,attrs);
/// 
///     // Recreate/resize surface upon resize
///     bindSizeEvent( (_) => updateCamera() );
/// 
///   late MyGLContext _glContext;
/// 
///   void updateCamera()
///   {
///     // Render into this canvas from now on
///     setCurrent(_glContext);
/// 
///     final size = getClientSize();
///     _glContext.viewport( 0, 0, size.x, size.y );
/// 
///     // draw something
///     _glContext.render();
/// 
///     // done!
///     swapBuffers();
///   }
/// }
///```

class WxGLCanvas extends WxWindow {
  WxGLCanvas( WxWindow parent, WxGLAttributes dispAttrs, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
  : super( parent, id, pos, size, style )
  {
    _setupPlugin();
    bindWindowCreateEvent( (_) {
      onInternalIdle();
      //final size = getSize();
      //print( "window create: ${size.x},${size.y}" );
    }, -1);
  }

  @override
  void onInternalIdle() 
  {
    final size = getSize();
    if ((_texture != null) && (_flutterGlPlugin != null))
    {
        if ((size.x != _oldSize.x) || (size.y != _oldSize.y))
        {
          final options = AngleOptions(
            width: size.x, 
            height: size.y, 
            dpr: 1.0,
            antialias: true,
            useSurfaceProducer: true
          );

          if (wxIsWeb())
          {
            // this is needed to due a bug in flutter_angle on the web
            _webglTextureResize( size.x, size.y ).then( (_) {
              _oldSize = size;
              final event = WxSizeEvent( size, id: getId() );
              processEvent( event );
            }  );
          } else {
            _flutterGlPlugin!.resize( _texture!, options ).then( (_) {
              _oldSize = size;
              final event = WxSizeEvent( size, id: getId() );
              processEvent( event );
            } );
          }
          
        }
    }
    super.onInternalIdle();
  }

  Future<void> _webglTextureResize( int width, int height ) async
  {
    /*
      final dynamic surfaceID = _texture!.surfaceId;
      final element = surfaceID as html.HTMLCanvasElement;
      element.width = width;
      element.height = height;
    */
  }

  WxGLContext? _context;
  RenderingContext? _gl;
  FlutterAngleTexture? _texture;
  WxSize _oldSize = wxDefaultSize;
  bool _buildingTexture = false;

  /// Swap buffers after drawing is completed
  void swapBuffers()
  {
    if (_flutterGlPlugin == null) {
      wxLogError( "Angle not initalized" );
      return; 
    }

    if (_gl == null) return;
    // push all changes to the FBO
    _gl!.finish();

    if (_texture == null) return;
    _flutterGlPlugin!.updateTexture(_texture!).then( (_) {
        //print( "#2 Texture updated" );
    });
  }

  /// Makes [context] use this canvas to draw into
  /// 
  /// return true on success
  bool setCurrent( WxGLContext context )
  {
    if (_flutterGlPlugin == null) {
      wxLogError( "Angle not initalized" );
      return false; 
    }

    _context = context;
    if (_gl != null) {
      _context!._gl = _gl!;
    }
    if (_texture != null) {
//       _flutterGlPlugin!.activateTexture(_texture!);
        _texture!.activate();
      return true;
    }
    return false;
  }

  void _setupPlugin() async
  {
    if (_flutterGlPlugin == null) 
    {
      _flutterGlPlugin = FlutterAngle();
      await _flutterGlPlugin!.init();
    }
  }

  void _setupTexture() async
  {
    _buildingTexture = true;
    WxSize size = getSize();

    final options = AngleOptions(
        width: size.x < 2 ? 600 : size.x, 
        height: size.y < 2 ? 500 : size.y, 
        dpr: 1.0,
        antialias: true,
        useSurfaceProducer: true
    );

    _flutterGlPlugin!.createTexture( options ).then( (texture) {
      _texture = texture;
      _gl = _texture!.getContext();
      _buildingTexture = false;

      if (_context != null)
      {
        _texture!.activate();
        _context!.setCurrent(this);
        _context!.onPrepare();
      }
      _setState();
    } );  }

  @override
  Widget _build( BuildContext context )
  {
    if (_flutterGlPlugin == null) {
      return Text( "No GL plugin created" );
    }
    if (_texture == null) {
      if (!_buildingTexture) {
        _setupTexture();
      }
      return Text( "Building defaultFramebufferTexture..." );
    }
    if (_gl == null) {
      return Text( "GL context not set up yet" );
    }
    
    return
      _doBuildSystemEventHandlers(context,
        _doBuildSizeEventHandler(context, 
          Builder(builder: (BuildContext context) {
              if (kIsWeb) {
                return HtmlElementView( viewType: _texture!.textureId.toString() );
              } else {
                return Transform.scale( 
                    scaleY: -1, 
                    child: Texture(textureId: _texture!.textureId ) );
              }
            } ) ) );
  }
}

// ------------------------- wxGLContext ----------------------

/// Helper class to hold the reference to an OpenGL buffer
/// 
/// Used by [WxGLContext]
class WxGlBuffer extends Buffer {
  /// Used internally
  WxGlBuffer(super.id);

  /// Returns ID of the buffer
  int getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL render buffer
/// 
/// Used by [WxGLContext]
class WxGlRenderbuffer extends Renderbuffer {
  /// Used internally
  WxGlRenderbuffer(super.id);

  /// Returns ID of the render buffer
  int getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL texture
/// 
/// Used by [WxGLContext]
class WxGlTexture extends WebGLTexture {
  /// Used internally
  WxGlTexture(super.id);

  /// Returns ID of the texture
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL vertex array object
/// 
/// Used by [WxGLContext]
class WxGlVertexArrayObject extends VertexArrayObject {
  /// Used internally
  WxGlVertexArrayObject(super.id);

  /// Returns ID of the vertex array object
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL program
/// 
/// Used by [WxGLContext]
class WxGlProgram extends Program {
  /// Used internally
  WxGlProgram(super.id);

  /// Returns ID of the GL program
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL shader
/// 
/// Used by [WxGLContext]
class WxGlShader extends WebGLShader {
  /// Used internally
  WxGlShader(super.id);

  /// Returns ID of the shader
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL frame buffer
/// 
/// Used by [WxGLContext]
class WxGlFramebuffer extends Framebuffer {
  /// Used internally
  WxGlFramebuffer(super.id);

  /// Returns ID of the frame buffer
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL location
/// 
/// Used by [WxGLContext]
class WxGlUniformLocation extends UniformLocation {
  /// Used internally
  WxGlUniformLocation(super.id);

  /// Returns ID of the location
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL transform feedback
/// 
/// Used by [WxGLContext]
class WxGlTransformFeedback extends TransformFeedback {
  /// Used internally
  WxGlTransformFeedback(super.id);

  /// Returns ID of the transform feedback
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL active info structure
/// 
/// Used by [WxGLContext]
class WxGlActiveInfo extends ActiveInfo {
  /// Used internally
  WxGlActiveInfo(super.type, super.name, super.size);

  /// returns the type
  int getType() {
    return type; 
  }
  /// returns the name
  String getName() {
    return name; 
  }
  /// returns the size
  int getSize() {
    return size; 
  }
}

/// Helper class to hold the reference to an OpenGL parameter
/// 
/// Used by [WxGLContext]
class WxGlParameter extends WebGLParameter {
  /// Used internally
  WxGlParameter(super.id);

  /// Returns ID of the parameter
  int getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL shader precision format
/// 
/// Used by [WxGLContext]
class WxGlShaderPrecisionFormat extends ShaderPrecisionFormat {
  /// Used internally
  WxGlShaderPrecisionFormat( int precision, int min, int max ) {
    _setPrecision(precision);
    _setRange( min, max );
  }

  void _setPrecision( int precision ) {
    this.precision = precision;
  }
  /// Returns precision
  int getPrecision() {
    return precision;
  }
  void _setRange( int min, int max ) {
    rangeMin = min;
    rangeMax = max;
  }
  /// Returns min of range
  int getMin() {
    return rangeMin;
  }
  /// Returns max of range
  int getMax() {
    return rangeMax;
  }
}

/// Represents an OpenGL ES/WebGL rendering context for use with [WxGLCanvas].
/// 
/// [WxGLContext] mirrors the API implemented from the  flutter_angle project
/// which in turn
/// uses the ANGLE libary to draw directly into a flutter surface. In wxDart
/// Native, [WxGLContext] calls the OpenGL API directly and it is therefore
/// important to set up the [WxGLCanvas] in the correct mode and/or to use
/// a syntax and shader dialect that works e.g. across OpenGL 4.1 on macOS
/// as well as OpenGL ES 3.X everywhere else.
/// 
/// In both wxDart Flutter and wxDart Native, GL calls should be done through
/// the [WxGLContext] API like this:
/// 
///```dart
/// {
///     final gl = this;  // WxGlContext
///     gl.useProgram(_glProgram);
///     gl.drawArrays(WebGL.TRIANGLES, 0, 3);
///     gl.flush();
/// }
///```
/// 
/// In wxDart Native alone, you can also use the OpenGL API directly
///```dart
/// {
///     glUseProgram(_glProgram.getId());
///     glDrawArrays(GL_TRIANGLES, 0, 3);
///     glFlush();
/// }
///```
/// 
/// see [WxGLCanvas]
/// 
///```dart
/// class MyGLContext extends WxGLContext
/// {
///   MyGLContext( WxGLCanvas canvas, WxGLContextAttrs attrs ) : super( canvas, attrs )
///   {
///     setCurrent(canvas);
///   }
/// 
///   late WxGlProgram _glProgram;
///   late WxGlBuffer _triangleVertexBuffer;
///   late WxGlUniformLocation _vertexLocation;
///   late WxGlVertexArrayObject _vao;
/// 
///   @override
///   void onPrepare()
///   {
///     final gl = this;
/// 
///     final version = gl.getString( WebGL.SHADING_LANGUAGE_VERSION );
///     final versionString = version.contains("ES") ? "300 es" : "150";
/// 
///     final vs = """#version $versionString
///            #define attribute in
///            #define varying out
///            attribute vec3 a_Position;
///            // layout (location = 0) in vec3 a_Position;
///            void main() {
///                gl_Position = vec4(a_Position, 1.0);
///            }
///     """;
///    final fs = """#version $versionString
///             precision mediump float;
///             out vec4 FragColor;
/// 
///             void main(void) {
///                 FragColor = vec4(1.0, 1.0, 0.0, 1.0);
///             }
///     """;
/// 
///     // Compile vertex shader
///     final vertexShader = gl.createShader(WebGL.VERTEX_SHADER);
///     gl.shaderSource(vertexShader, vsSource);
///     gl.compileShader(vertexShader);
/// 
///     // Compile fragment shader ...
///     final fragmentShader = gl.createShader(WebGL.FRAGMENT_SHADER);
///     gl.shaderSource(fragmentShader, fsSource);
///     gl.compileShader(fragmentShader);
/// 
///     // Create program and bind shaders
///     _glProgram = gl.createProgram();
///     gl.attachShader(_glProgram, vertexShader);
///     gl.attachShader(_glProgram, fragmentShader);
///     gl.linkProgram(_glProgram);
///     gl.useProgram(_glProgram);
/// 
///     // Create triangle
///     final vertices = Float32List.fromList([
///       -0.5, -0.5, 0, // Vertice #2
///       0.5, -0.5, 0, // Vertice #3
///       0, 0.5, 0, // Vertice #1
///     ]);
/// 
///     _vao = gl.createVertexArray();
///     gl.bindVertexArray( _vao );
/// 
///     _triangleVertexBuffer = gl.createBuffer();
///     gl.bindBuffer(gl.ARRAY_BUFFER, _triangleVertexBuffer); 
///     gl.bufferData(gl.ARRAY_BUFFER, vertices, WebGL.STATIC_DRAW);
/// 
///     _vertexLocation = gl.getAttribLocation( _glProgram, "a_Position" );
///     gl.enableVertexAttribArray(_vertexLocation.getId());
///   }
/// 
///   void render()
///   {
///     final gl = this;
/// 
///     // bind to VAO
///     gl.bindVertexArray( _vao );
///  
///     // use program   
///     gl.useProgram(_glProgram);
/// 
///     // Set up canvas
///     gl.clearColor(0, 0, 0, 1.0);
///     gl.clear(WebGL.COLOR_BUFFER_BIT | WebGL.DEPTH_BUFFER_BIT );
///     gl.enable(WebGL.DEPTH_TEST);
///     gl.disable(WebGL.BLEND);
/// 
///     // bind to vertex buffer
///     gl.bindBuffer(WebGL.ARRAY_BUFFER, _triangleVertexBuffer );
///     gl.vertexAttribPointer(_vertexLocation.getId(), 3, WebGL.FLOAT, false, 0, 0);
/// 
///     // draw triagle
///     gl.drawArrays(WebGL.TRIANGLES, 0, 3);
/// 
///     gl.flush();
///   }
///```

abstract class WxGLContext extends WxObject {

  /// Creates a GL context. Usually called in the constructor of
  /// a [WxGLCanvas]
  WxGLContext( WxGLCanvas canvas, WxGLContextAttrs attr ) {
    _gl = canvas._gl;
    canvas._context = this;
  }

  RenderingContext? _gl;
  bool _isPrepared = false;

  /// Must be overrridden. Set up your context in this method which
  /// will get called immediately in wxDart Native and delayed in
  /// wxDart Flutter
  void onPrepare();

  /// Returns true if the context has been set up and can be drawn into
  bool isOK( ) {
    return _gl != null;
  }

  int getWidth() {
    if (_gl == null) return -1;
    return _gl!.width;
  }

  int getHeight() {
    if (_gl == null) return -1;
    return _gl!.height;
  }

  /// Makes this context the current context
  /// 
  /// return true on success
  bool setCurrent( WxGLCanvas canvas ) {
    _gl = canvas._gl;
    return canvas.setCurrent( this );
  }


  int doSomething( int i, String str ) {
    return 0;
  }

  void scissor(int x, int y, int z, int w) {
    _gl!.scissor(x,y,z,w);
  }

  void viewport(int x, int y, int width, int height) {
    _gl!.viewport(x,y,width,height);
  }

  WxGlShaderPrecisionFormat getShaderPrecisionFormat( int shaderType, int precisionType) {
    final res = _gl!.getShaderPrecisionFormat(shaderType,precisionType);
    return WxGlShaderPrecisionFormat( res.precision, res.rangeMin, res.rangeMax );
  }

  Object? getExtension(String key) {
    final res = _gl!.getExtension(key);
    return res;
  }

  Object? getExtensionDesktop(String key) {
    final res = _gl!.getExtension(key);
    return res;
  }

  String getString(int key)
  {
    if (key == WebGL.EXTENSIONS) { 
        return 'unknown';
    } else 
    if (key == WebGL.VENDOR) { 
        return 'Google';
    } else
    if (key == WebGL.RENDERER) { 
        return 'ANGLE';
    } else
    if (key == WebGL.VERSION) { 
        return '3.3 ES';
    } else
    if (key == WebGL.SHADING_LANGUAGE_VERSION) { 
        return 'GLSL 3.3 ES';
    } 
    return "unnamed";
  }

  int getParameter(int key) {
    return _gl!.getParameter( key );
  }

  WxGlTexture createTexture() { 
    return WxGlTexture( _gl!.createTexture().id );
  }

  void bindTexture(int type, WxGlTexture? texture) {
    _gl!.bindTexture( type, texture );
  }

  void bindTexture2(WxGlTexture texture) {
    _gl!.bindTexture( WebGL.TEXTURE_2D, texture );
  }

  void activeTexture(int v0) {
    _gl!.activeTexture( v0 );
  }

  void texParameteri(int v0, int v1, int v2) {
    _gl!.texParameteri( v0, v1, v2 );
  }

  void texImage2D(int target, int level, int internalformat, int width,
      int height, int border, int format, int type, TypedData? pixels) {
    _gl!.texImage2D( target, level, internalformat, width,
      height, border, format, type, pixels );
  }

  void texImage2D_NOSIZE(
      int target, int level, int internalformat, int format, int type, TypedData? pixels) {
    wxLogError( "texImage2D_NOSIZE not implemented" );
    // _gl!.texImage2D_NOSIZE( target, level, internalformat, format, type, pixels );
  }

  void texImage3D(int target, int level, int internalformat, int width,
      int height, int depth, int border, int format, int type, TypedData? pixels ) {
    _gl!.texImage3D( target, level, internalformat, width,
      height, depth, border, format, type, pixels );
  }

  void depthFunc(int v0) {
    _gl!.depthFunc( v0);
  }

  void depthMask(bool v0) {
    _gl!.depthMask( v0);
  }

  void enable(int v0) {
    _gl!.enable( v0);
  }

  void disable(int v0) {
    _gl!.disable( v0);
  }

  void blendEquation(int v0) {
    _gl!.blendEquation( v0);
  }

  void useProgram(WxGlProgram? program) {
    _gl!.useProgram( program );
  }

  void blendFuncSeparate(int v0, int v1, int v2, int v3) {
    _gl!.blendFuncSeparate( v0, v1, v2, v3 );
  }

  void blendFunc(int v0, int v1) {
    _gl!.blendFunc( v0, v1 );
  }

  void blendEquationSeparate(int var0, int var1) {
    _gl!.blendEquationSeparate( var0, var1 );
  }

  void frontFace(int v0) {
    _gl!.frontFace( v0 );
  }

  void cullFace(int mode) {
    _gl!.cullFace( mode );
  }

  void lineWidth(double width) {
    _gl!.lineWidth( width );
  }

  void polygonOffset(double v0, double v1) {
    _gl!.polygonOffset( v0, v1 );
  }

  void stencilMask(int mask) {
    _gl!.stencilMask(mask);
  }

  void stencilFunc(int func, int ref, int mask) {
    _gl!.stencilFunc(func, ref, mask);
  }

  void stencilOp(int fail, int zfail, int zpass) {
    _gl!.stencilOp(fail, zfail, zpass);
  }

  void clearStencil(int s) {
    _gl!.clearStencil( s );
  }

  void clearDepth(double v0) {
    _gl!.clearDepth( v0 );
  }

  void colorMask(bool v0, bool v1, bool v2, bool v3) {
    _gl!.colorMask( v0, v1, v2, v3 );
  }

  void clearColor(double r, double g, double b, double a) {
    _gl!.clearColor( r, g, b, a );
  }

  void compressedTexImage2D(int target, int level, int internalformat,
      int width, int height, int border, TypedData? data) {
    _gl!.compressedTexImage2D( target, level, internalformat,
      width, height, border, data );
  }

  void compressedTexImage3D(int target, int level, int internalformat,
      int width, int height, int depth, int border, TypedData? data) {
    _gl!.compressedTexImage3D( target, level, internalformat,
      width, height, depth, border, data );
  }

  void generateMipmap(int v0) { 
    _gl!.generateMipmap( v0 );
  }

  void deleteTexture(WxGlTexture v0) { 
    _gl!.deleteTexture( v0 );
  }

  void deleteFramebuffer(WxGlFramebuffer v0) { 
    _gl!.deleteFramebuffer( v0 );
  }

  void deleteRenderbuffer(WxGlRenderbuffer v0) { 
    _gl!.deleteRenderbuffer( v0 );
  }

  void texParameterf(int target, int pname, double param) {
    _gl!.texParameterf( target, pname, param );
  }

  void pixelStorei(int v0, int v1) {
    _gl!.pixelStorei( v0, v1 );
  }

  dynamic getContextAttributes() {
    return _gl!.getContextAttributes();
  }

  WxGlParameter getProgramParameter(WxGlProgram program, int pname) {
    return WxGlParameter( _gl!.getProgramParameter( program, pname).id );
  }

  int getUniformBlockIndex( WxGlProgram program, String name ) {
    return _gl!.getUniformBlockIndex( program, name );
  }

  void uniformBlockBinding( WxGlProgram program, int uniformBlockIndex, int uniformBlockBinding ) {
    _gl!.uniformBlockBinding( program, uniformBlockIndex, uniformBlockBinding );
  }

  WxGlActiveInfo getActiveUniform(WxGlProgram program, int v1) {
    final info = _gl!.getActiveUniform( program, v1 );
    return WxGlActiveInfo( info.type, info.name, info.size );
  }

  WxGlActiveInfo getActiveAttrib(WxGlProgram program, int v1) {
    final info = _gl!.getActiveAttrib( program, v1 );
    return WxGlActiveInfo( info.type, info.name, info.size );
  }

  WxGlUniformLocation getUniformLocation(WxGlProgram program, String name) {
    return WxGlUniformLocation( _gl!.getUniformLocation( program, name ).id );
  }

  void clear(int v0) {
    _gl!.clear( v0 );
  }

  WxGlBuffer createBuffer() {
    return WxGlBuffer( _gl!.createBuffer().id );
  }

  void deleteBuffer(WxGlBuffer v0) {
    _gl!.deleteBuffer( v0 );
  }

  void bindBuffer(int v0, WxGlBuffer? v1) {
    _gl!.bindBuffer( v0, v1 );
  }

  void bufferData(int target, TypedData data, int? usage) {
    _gl!.bufferData( target, data, usage );
  }

  void bufferDataSize(int target, int size, int? usage) {
    _gl!.bufferData( target, size, usage );
  }

  void clearBufferiv( int buffer, int drawbuffer, int value ) {
    _gl!.clearBufferiv( buffer, drawbuffer, value );
  }

  void clearBufferuiv( int buffer, int drawbuffer, int value ) {
    _gl!.clearBufferuiv( buffer, drawbuffer, value );
  }

  void bufferSubData(int target, int dstByteOffset, TypedData data ) {
    _gl!.bufferSubData( target, dstByteOffset, data );
  }

  void vertexAttribPointer(
      int index, int size, int type, bool normalized, int stride, int offset) {
    _gl!.vertexAttribPointer( index, size, type, normalized, stride, offset);
  }

  void drawArrays(int v0, int v1, int v2) {
    _gl!.drawArrays(v0, v1, v2);
  }

  void drawArraysInstanced(int v0, int v1, int v2, int v3) {
    _gl!.drawArraysInstanced( v0, v1, v2, v3 );
  }

  void bindFramebuffer(int target, WxGlFramebuffer? v1) {
    _gl!.bindFramebuffer( target, v1 );
  }

  int checkFramebufferStatus(int target) {
    return _gl!.checkFramebufferStatus( target );
  }

  void framebufferTexture2D(int target, int attachment, int textarget, WxGlTexture ?texture, int level) {
    _gl!.framebufferTexture2D( target, attachment, textarget, texture, level );
  }

  void framebufferTextureLayer(int target, int attachment, WxGlTexture? texture, int level, int layer) {
    _gl!.framebufferTextureLayer( target, attachment, texture, level, layer );
  }

  void readPixels(int x, int y, int width, int height, int format, int type, TypedData pixels ) {
    _gl!.readPixels(x, y, width, height, format, type, pixels );
  }

  void copyTexImage2D(int target, int level, int internalformat, int x, int y, int width, int height, int border) {
    _gl!.copyTexImage2D( target, level, internalformat, x, y, width, height, border );
  }

  void copyTexSubImage2D(int target, int level, int xOffset, int yOffset, int x, int y, int width, int height) {
    _gl!.copyTexSubImage2D( target, level, xOffset, yOffset, x, y, width, height );
  }

  void copyTexSubImage3D(int target, int level, int xOffset, int yOffset, int zOffset, int x, int y, int width, int height) {
    _gl!.copyTexSubImage3D( target, level, xOffset, yOffset, zOffset, x, y, width, height );
  }

  void texSubImage2D(int target, int level, int x, int y, int width, int height, int format, int type, TypedData? pixels) {
    _gl!.texSubImage2D( target, level, x, y, width, height, format, type, pixels );
  }

  void texSubImage2D_NOSIZE(int target, int level, int x, int y, int format, int type, TypedData? pixels) {
    _gl!.texSubImage2D_NOSIZE( target, level, x, y, format, type, pixels );
  }

  void texSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth,
      int format, int type, TypedData? pixels) {
    _gl!.texSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, pixels );
  }

  void compressedTexSubImage2D(int target, int level, int xoffset, int yoffset, int width, int height,
      int format, TypedData? pixels) {
    _gl!.compressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, pixels );
  }

  void compressedTexSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, 
      int width, int height, int depth, int format, TypedData? pixels) {
    _gl!.compressedTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, pixels );
  }

  void bindRenderbuffer(int target, WxGlRenderbuffer? buffer) {
    _gl!.bindRenderbuffer( target, buffer );
  }

  void renderbufferStorageMultisample(
      int target, int samples, int internalformat, int width, int height) {
    _gl!.renderbufferStorageMultisample(target, samples, internalformat, width, height);
  }

  void renderbufferStorage(int v0, int v1, int v2, int v3) {
    _gl!.renderbufferStorage(v0, v1, v2, v3);
  }

  void framebufferRenderbuffer(int v0, int v1, int v2, WxGlRenderbuffer? buffer) {
    _gl!.framebufferRenderbuffer( v0, v1, v2, buffer );
  }

  WxGlRenderbuffer createRenderbuffer() {
    return WxGlRenderbuffer( _gl!.createRenderbuffer() );
  }

  WxGlFramebuffer createFramebuffer() {
    return WxGlFramebuffer( _gl!.createFramebuffer() );
  }

  void blitFramebuffer(
      int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1, int mask, int filter) {
    _gl!.blitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
  }

  WxGlVertexArrayObject createVertexArray() {
    return WxGlVertexArrayObject( _gl!.createVertexArray().id );
  }

  WxGlProgram createProgram() {
    return WxGlProgram( _gl!.createProgram().id );
  }

  void attachShader(WxGlProgram v0, WxGlShader v1) {
    _gl!.attachShader( v0, v1 );
  }

  bool isProgram(WxGlProgram v0) {
    return _gl!.isProgram(v0);
  }

  void bindAttribLocation( WxGlProgram program, int index, String name) {
    _gl!.bindAttribLocation( program, index, name );
  }

  void linkProgram(WxGlProgram v0) {
    _gl!.linkProgram( v0 );
  }

  String? getProgramInfoLog(WxGlProgram v0) {
    return _gl!.getProgramInfoLog( v0 );
  }

  String? getShaderInfoLog(WxGlShader v0) {
    return _gl!.getShaderInfoLog( v0 );
  }

  int getError() {
    return _gl!.getError();
  }

  void deleteShader(WxGlShader v0) {
    _gl!.deleteShader( v0 );
  }

  void deleteProgram(WxGlProgram v0) {
    _gl!.deleteProgram( v0 );
  }

  void bindVertexArray(WxGlVertexArrayObject v0) {
    _gl!.bindVertexArray( v0 );
  }

  void deleteVertexArray(WxGlVertexArrayObject v0) {
    _gl!.deleteVertexArray( v0 );
  }

  void enableVertexAttribArray(int v0) {
    _gl!.enableVertexAttribArray( v0 );
  }

  void disableVertexAttribArray(int v0) {
    _gl!.disableVertexAttribArray( v0 );
  }

  void vertexAttribIPointer(int v0, int v1, int v2, int v3, int v4) {
    _gl!.disableVertexAttribArray( v0 );
  }

  void vertexAttrib2fv(int index, Float32List values) {
    _gl!.vertexAttrib2fv( index, values );
  }

  void vertexAttrib3fv(int index, Float32List values) {
    _gl!.vertexAttrib3fv( index, values );
  }

  void vertexAttrib4fv(int index, Float32List values) {
    _gl!.vertexAttrib4fv( index, values );
  }

  void vertexAttrib1fv(int index, Float32List values) {
    _gl!.vertexAttrib1fv( index, values );
  }

  void drawElements(int mode, int count, int type, int offset) {
    _gl!.drawElements( mode, count, type, offset );
  }

  void drawBuffers(Uint32List buffers) {
    _gl!.drawBuffers( buffers );
  }

  void drawElementsInstanced(int mode, int count, int type, int offset, int instanceCount) {
    _gl!.drawElementsInstanced(mode, count, type, offset, instanceCount);
  }

  WxGlShader createShader(int type) {
    return WxGlShader( _gl!.createShader(type).id );
  }

  void shaderSource(WxGlShader v0, String shaderSource) {
    _gl!.shaderSource( v0, shaderSource );
  }

  void compileShader(WxGlShader v0) {
    _gl!.compileShader( v0 );
  }

  bool getShaderParameter(WxGlShader v0, int v1) {
    return _gl!.getShaderParameter( v0, v1 );
  }

  String? getShaderSource(WxGlShader v0) {
    return null;
    // return _gl!.getShaderSource( v0.getId() );
  }

  WxGlUniformLocation getAttribLocation(WxGlProgram program, String name) {
    return WxGlUniformLocation( _gl!.getAttribLocation( program, name ).id );
  }

  // Single int

  void uniform1i(WxGlUniformLocation location, int x) {
    _gl!.uniform1i( location, x );
  }

  // Single floats

  void uniform1f(WxGlUniformLocation location, double x) {
    _gl!.uniform1f( location, x );
  }

  void uniform2f( WxGlUniformLocation location, double x, double y) {
    _gl!.uniform2f( location, x, y);
  }

  void uniform3f(WxGlUniformLocation location, double v1, double v2, double v3) {
    _gl!.uniform3f( location, v1, v2, v3 );
  }

  void uniform4f(WxGlUniformLocation location, double v0, double v1, double v2, double v3) {
    _gl!.uniform4f( location, v0, v1, v2, v3 );
  }

  // Float lists

  void uniform1fv(WxGlUniformLocation location, Float32List values ) {
    _gl!.uniform1fv( location, values );
  }

  void uniform2fv(WxGlUniformLocation location, Float32List values ) {
    _gl!.uniform2fv( location, values );
  }

  void uniform3fv(WxGlUniformLocation location, Float32List values) {
    _gl!.uniform3fv( location, values );
  }

  void uniform4fv(WxGlUniformLocation location, Float32List values) {
    _gl!.uniform4fv( location, values );
  }

  // Float list transpose

  void uniformMatrix2fv(WxGlUniformLocation location, bool transpose, Float32List values ) {
    _gl!.uniformMatrix2fv( location, transpose, values );
  }

  void uniformMatrix3fv(WxGlUniformLocation location, bool transpose, Float32List values ) {
    _gl!.uniformMatrix3fv( location, transpose, values );
  }

  void uniformMatrix4fv(WxGlUniformLocation location, bool transpose, Float32List values ) {
    _gl!.uniformMatrix4fv( location, transpose, values );
  }

  // Int lists

  void uniform1iv(WxGlUniformLocation location, Int32List values) {
    _gl!.uniform1iv( location, values );
  }

  void uniform2iv(WxGlUniformLocation location, Int32List values ) {
    _gl!.uniform2iv( location, values );
  }

  void uniform3iv(WxGlUniformLocation location, Int32List values) {
    _gl!.uniform3iv( location, values );
  }

  void uniform4iv(WxGlUniformLocation location, Int32List values) {
    _gl!.uniform4iv( location, values );
  }

  // Single Uint

  void uniform1ui(WxGlUniformLocation location, int value) {
    _gl!.uniform1ui( location, value );
  }

  // Uint lists

  void uniform1uiv(WxGlUniformLocation location, Uint32List values ) {
    _gl!.uniform1uiv( location, values );
  }

  void uniform2uiv(WxGlUniformLocation location, Uint32List values ) {
    _gl!.uniform2uiv( location, values );
  }

  void uniform3uiv(WxGlUniformLocation location, Uint32List values) {
    _gl!.uniform3uiv( location, values );
  }

  void uniform4uiv(WxGlUniformLocation location, Uint32List values) {
    _gl!.uniform4uiv( location, values );
  }

  void vertexAttribDivisor(int index, int divisor) {
    _gl!.vertexAttribDivisor( index, divisor );
  }

  void flush() {
    _gl!.flush();
  }

  void finish() {
    _gl!.finish();
  }

  void texStorage2D(int target, int levels, int internalformat, int width, int height) {
    _gl!.texStorage2D(target, levels, internalformat, width, height);
  }

  void texStorage3D(int target, int levels, int internalformat, int width, int height, int depth) {
    _gl!.texStorage3D(target, levels, internalformat, width, height, depth );
  }
  
  void bindBufferBase(int target, int index, WxGlBuffer? buffer) {
    _gl!.bindBufferBase( target, index, buffer );
  }

  WxGlTransformFeedback createTransformFeedback() {
    final res = _gl!.createTransformFeedback();
    return WxGlTransformFeedback( res.id );
  }

  void bindTransformFeedback(int target, WxGlTransformFeedback transformFeedback) {
    _gl!.bindTransformFeedback( target, transformFeedback );
  }

  void transformFeedbackVaryings(WxGlProgram program, int count, List<String> varyings, int bufferMode) {
    _gl!.transformFeedbackVaryings( program, count, varyings, bufferMode );
  }

  void deleteTransformFeedback(WxGlTransformFeedback transformFeedback) {
    _gl!.deleteTransformFeedback(transformFeedback);
  }

  bool isTransformFeedback(WxGlTransformFeedback transformFeedback) {
    return _gl!.isTransformFeedback(transformFeedback);
  }

  void beginTransformFeedback(int primitiveMode) {
    _gl!.beginTransformFeedback(primitiveMode );
  }
  void endTransformFeedback() {
    _gl!.endTransformFeedback();
  }
  void pauseTransformFeedback() {
    _gl!.pauseTransformFeedback();
  }
  void resumeTransformFeedback() {
    _gl!.resumeTransformFeedback();
  }

  WxGlActiveInfo getTransformFeedbackVarying(WxGlProgram program, int index) {
    final info = _gl!.getTransformFeedbackVarying( program, index );
    return WxGlActiveInfo( info.type, info.name, info.size );
  }

  void invalidateFramebuffer( int target, Uint32List attachments) {
    _gl!.invalidateFramebuffer( target, attachments );
  }

}

