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
              // Does not get here in WebGL mode
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
  bool setCurrent( WxGLContext context ) {
    _context = context;
    if (_gl != null) {
      _context!._gl = _gl!;
    }
    if (_texture != null) {
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
        _doBuildSizeEventHandler(context, 
          Builder(builder: (BuildContext context) {
              if (kIsWeb) {
                return HtmlElementView( viewType: _texture!.textureId.toString() );
              } else {
                return Transform.scale( 
                    scaleY: -1, 
                    child: Texture(textureId: _texture!.textureId ) );
              }
            } ) );
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
///     gl.drawArrays(gl.TRIANGLES, 0, 3);
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
///     final version = gl.getString( gl.SHADING_LANGUAGE_VERSION );
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
///     final vertexShader = gl.createShader(gl.VERTEX_SHADER);
///     gl.shaderSource(vertexShader, vsSource);
///     gl.compileShader(vertexShader);
/// 
///     // Compile fragment shader ...
///     final fragmentShader = gl.createShader(gl.FRAGMENT_SHADER);
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
///     gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);
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
///     gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT );
///     gl.enable(gl.DEPTH_TEST);
///     gl.disable(gl.BLEND);
/// 
///     // bind to vertex buffer
///     gl.bindBuffer(gl.ARRAY_BUFFER, _triangleVertexBuffer );
///     gl.vertexAttribPointer(_vertexLocation.getId(), 3, gl.FLOAT, false, 0, 0);
/// 
///     // draw triagle
///     gl.drawArrays(gl.TRIANGLES, 0, 3);
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

  WxGlShaderPrecisionFormat getShaderPrecisionFormat() {
    final res = _gl!.getShaderPrecisionFormat(0,0);
    return WxGlShaderPrecisionFormat( res.precision, res.rangeMin, res.rangeMax );
  }

  List<String> getExtension(String key) {
    final res = _gl!.getExtension(key);
    return [];
  }

  List<String> getExtensionDesktop(String key) {
    return [];
  }

  String getString(int key)
  {
    if (key == EXTENSIONS) { 
        return 'unknown';
    } else 
    if (key == VENDOR) { 
        return 'Google';
    } else
    if (key == RENDERER) { 
        return 'ANGLE';
    } else
    if (key == VERSION) { 
        return '3.3 ES';
    } else
    if (key == SHADING_LANGUAGE_VERSION) { 
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
    _gl!.bindTexture( TEXTURE_2D, texture );
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

  void useProgram(WxGlProgram program) {
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

  void bindBuffer(int v0, WxGlBuffer v1) {
    _gl!.bindBuffer( v0, v1 );
  }

  void bufferData(int target, TypedData data, int? usage) {
    _gl!.bufferData( target, data, usage );
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

  void readPixels(int x, int y, int width, int height, int format, int type, TypedData pixels ) {
    _gl!.readPixels(x, y, width, height, format, type, pixels );
  }

  void copyTexImage2D(int target, int level, int internalformat, int x, int y, int width, int height, int border) {
    _gl!.copyTexImage2D( target, level, internalformat, x, y, width, height, border );
  }

  void texSubImage2D(int target, int level, int x, int y, int width, int height, int format, int type, TypedData? pixels) {
    _gl!.texSubImage2D( target, level, x, y, width, height, format, type, pixels );
  }

  void texSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth,
      int format, int type, TypedData? pixels) {
    _gl!.texSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, pixels );
  }

  void compressedTexSubImage2D(int target, int level, int xoffset, int yoffset, int width, int height,
      int format, TypedData? pixels) {
    _gl!.compressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, pixels );
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
    dynamic id = location.getId();
    _gl!.uniform1i( UniformLocation( id ), x );
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


  // OpenGL 2.0
  int ACTIVE_ATTRIBUTES = 35721;
  int ACTIVE_ATTRIBUTE_MAX_LENGTH = 35722;
  int ACTIVE_TEXTURE = 34016;
  int ACTIVE_UNIFORMS = 35718;
  int ACTIVE_UNIFORM_MAX_LENGTH = 35719;
  int ALIASED_LINE_WIDTH_RANGE = 33902;
  int ALIASED_POINT_SIZE_RANGE = 33901;
  int ALPHA = 6406;
  int ALPHA_BITS = 3413;
  int ALWAYS = 519;
  int ARRAY_BUFFER = 34962;
  int ARRAY_BUFFER_BINDING = 34964;
  int ATTACHED_SHADERS = 35717;
  int BACK = 1029;
  int BLEND = 3042;
  int BLEND_COLOR = 32773;
  int BLEND_DST_ALPHA = 32970;
  int BLEND_DST_RGB = 32968;
  int BLEND_EQUATION = 32777;
  int BLEND_EQUATION_ALPHA = 34877;
  int BLEND_EQUATION_RGB = 32777;
  int BLEND_SRC_ALPHA = 32971;
  int BLEND_SRC_RGB = 32969;
  int BLUE_BITS = 3412;
  int BOOL = 35670;
  int BOOL_VEC2 = 35671;
  int BOOL_VEC3 = 35672;
  int BOOL_VEC4 = 35673;
  int BUFFER_SIZE = 34660;
  int BUFFER_USAGE = 34661;
  int BYTE = 5120;
  int CCW = 2305;
  int CLAMP_TO_EDGE = 33071;
  int COLOR_ATTACHMENT0 = 36064;
  int COLOR_BUFFER_BIT = 16384;
  int COLOR_CLEAR_VALUE = 3106;
  int COLOR_WRITEMASK = 3107;
  int COMPILE_STATUS = 35713;
  int COMPRESSED_TEXTURE_FORMATS = 34467;
  int CONSTANT_ALPHA = 32771;
  int CONSTANT_COLOR = 32769;
  int CULL_FACE = 2884;
  int CULL_FACE_MODE = 2885;
  int CURRENT_PROGRAM = 35725;
  int CURRENT_VERTEX_ATTRIB = 34342;
  int CW = 2304;
  int DECR = 7683;
  int DECR_WRAP = 34056;
  int DELETE_STATUS = 35712;
  int DEPTH_ATTACHMENT = 36096;
  int DEPTH_BITS = 3414;
  int DEPTH_BUFFER_BIT = 256;
  int DEPTH_CLEAR_VALUE = 2931;
  int DEPTH_COMPONENT = 6402;
  int DEPTH_COMPONENT16 = 33189;
  int DEPTH_FUNC = 2932;
  int DEPTH_RANGE = 2928;
  int DEPTH_TEST = 2929;
  int DEPTH_WRITEMASK = 2930;
  int DITHER = 3024;
  int DONT_CARE = 4352;
  int DST_ALPHA = 772;
  int DST_COLOR = 774;
  int DYNAMIC_DRAW = 35048;
  int ELEMENT_ARRAY_BUFFER = 34963;
  int ELEMENT_ARRAY_BUFFER_BINDING = 34965;
  int EQUAL = 514;
  int EXTENSIONS = 7939;
  int FALSE = 0;
  int FASTEST = 4353;
  int FIXED = 5132;
  int FLOAT = 5126;
  int FLOAT_MAT2 = 35674;
  int FLOAT_MAT3 = 35675;
  int FLOAT_MAT4 = 35676;
  int FLOAT_VEC2 = 35664;
  int FLOAT_VEC3 = 35665;
  int FLOAT_VEC4 = 35666;
  int FRAGMENT_SHADER = 35632;
  int FRAMEBUFFER = 36160;
  int FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = 36049;
  int FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = 36048;
  int FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = 36051;
  int FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = 36050;
  int FRAMEBUFFER_BINDING = 36006;
  int FRAMEBUFFER_COMPLETE = 36053;
  int FRAMEBUFFER_INCOMPLETE_ATTACHMENT = 36054;
  int FRAMEBUFFER_INCOMPLETE_DIMENSIONS = 36057;
  int FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = 36055;
  int FRAMEBUFFER_UNSUPPORTED = 36061;
  int FRONT = 1028;
  int FRONT_AND_BACK = 1032;
  int FRONT_FACE = 2886;
  int FUNC_ADD = 32774;
  int FUNC_REVERSE_SUBTRACT = 32779;
  int FUNC_SUBTRACT = 32778;
  int GENERATE_MIPMAP_HINT = 33170;
  int GEQUAL = 518;
  int GREATER = 516;
  int GREEN_BITS = 3411;
  int HIGH_FLOAT = 36338;
  int HIGH_INT = 36341;
  int IMPLEMENTATION_COLOR_READ_FORMAT = 35739;
  int IMPLEMENTATION_COLOR_READ_TYPE = 35738;
  int INCR = 7682;
  int INCR_WRAP = 34055;
  int INFO_LOG_LENGTH = 35716;
  int INT = 5124;
  int INT_VEC2 = 35667;
  int INT_VEC3 = 35668;
  int INT_VEC4 = 35669;
  int INVALID_ENUM = 1280;
  int INVALID_FRAMEBUFFER_OPERATION = 1286;
  int INVALID_OPERATION = 1282;
  int INVALID_VALUE = 1281;
  int INVERT = 5386;
  int KEEP = 7680;
  int LEQUAL = 515;
  int LESS = 513;
  int LINEAR = 9729;
  int LINEAR_MIPMAP_LINEAR = 9987;
  int LINEAR_MIPMAP_NEAREST = 9985;
  int LINES = 1;
  int LINE_LOOP = 2;
  int LINE_STRIP = 3;
  int LINE_WIDTH = 2849;
  int LINK_STATUS = 35714;
  int LOW_FLOAT = 36336;
  int LOW_INT = 36339;
  int LUMINANCE = 6409;
  int LUMINANCE_ALPHA = 6410;
  int MAX_COMBINED_TEXTURE_IMAGE_UNITS = 35661;
  int MAX_CUBE_MAP_TEXTURE_SIZE = 34076;
  int MAX_FRAGMENT_UNIFORM_VECTORS = 36349;
  int MAX_RENDERBUFFER_SIZE = 34024;
  int MAX_TEXTURE_IMAGE_UNITS = 34930;
  int MAX_TEXTURE_SIZE = 3379;
  int MAX_VARYING_VECTORS = 36348;
  int MAX_VERTEX_ATTRIBS = 34921;
  int MAX_VERTEX_TEXTURE_IMAGE_UNITS = 35660;
  int MAX_VERTEX_UNIFORM_VECTORS = 36347;
  int MAX_VIEWPORT_DIMS = 3386;
  int MEDIUM_FLOAT = 36337;
  int MEDIUM_INT = 36340;
  int MIRRORED_REPEAT = 33648;
  int NEAREST = 9728;
  int NEAREST_MIPMAP_LINEAR = 9986;
  int NEAREST_MIPMAP_NEAREST = 9984;
  int NEVER = 512;
  int NICEST = 4354;
  int NONE = 0;
  int NOTEQUAL = 517;
  int NO_ERROR = 0;
  int NUM_COMPRESSED_TEXTURE_FORMATS = 34466;
  int NUM_SHADER_BINARY_FORMATS = 36345;
  int ONE = 1;
  int ONE_MINUS_CONSTANT_ALPHA = 32772;
  int ONE_MINUS_CONSTANT_COLOR = 32770;
  int ONE_MINUS_DST_ALPHA = 773;
  int ONE_MINUS_DST_COLOR = 775;
  int ONE_MINUS_SRC_ALPHA = 771;
  int ONE_MINUS_SRC_COLOR = 769;
  int OUT_OF_MEMORY = 1285;
  int PACK_ALIGNMENT = 3333;
  int POINTS = 0;
  int POLYGON_OFFSET_FACTOR = 32824;
  int POLYGON_OFFSET_FILL = 32823;
  int POLYGON_OFFSET_UNITS = 10752;
  int RED_BITS = 3410;
  int RENDERBUFFER = 36161;
  int RENDERBUFFER_ALPHA_SIZE = 36179;
  int RENDERBUFFER_BINDING = 36007;
  int RENDERBUFFER_BLUE_SIZE = 36178;
  int RENDERBUFFER_DEPTH_SIZE = 36180;
  int RENDERBUFFER_GREEN_SIZE = 36177;
  int RENDERBUFFER_HEIGHT = 36163;
  int RENDERBUFFER_INTERNAL_FORMAT = 36164;
  int RENDERBUFFER_RED_SIZE = 36176;
  int RENDERBUFFER_STENCIL_SIZE = 36181;
  int RENDERBUFFER_WIDTH = 36162;
  int RENDERER = 7937;
  int REPEAT = 10497;
  int REPLACE = 7681;
  int RGB = 6407;
  int RGB565 = 36194;
  int RGB5_A1 = 32855;
  int RGBA = 6408;
  int RGBA4 = 32854;
  int SAMPLER_2D = 35678;
  int SAMPLER_CUBE = 35680;
  int SAMPLES = 32937;
  int SAMPLE_ALPHA_TO_COVERAGE = 32926;
  int SAMPLE_BUFFERS = 32936;
  int SAMPLE_COVERAGE = 32928;
  int SAMPLE_COVERAGE_INVERT = 32939;
  int SAMPLE_COVERAGE_VALUE = 32938;
  int SCISSOR_BOX = 3088;
  int SCISSOR_TEST = 3089;
  int SHADER_BINARY_FORMATS = 36344;
  int SHADER_COMPILER = 36346;
  int SHADER_SOURCE_LENGTH = 35720;
  int SHADER_TYPE = 35663;
  int SHADING_LANGUAGE_VERSION = 35724;
  int SHORT = 5122;
  int SRC_ALPHA = 770;
  int SRC_ALPHA_SATURATE = 776;
  int SRC_COLOR = 768;
  int STATIC_DRAW = 35044;
  int STENCIL_ATTACHMENT = 36128;
  int STENCIL_BACK_FAIL = 34817;
  int STENCIL_BACK_FUNC = 34816;
  int STENCIL_BACK_PASS_DEPTH_FAIL = 34818;
  int STENCIL_BACK_PASS_DEPTH_PASS = 34819;
  int STENCIL_BACK_REF = 36003;
  int STENCIL_BACK_VALUE_MASK = 36004;
  int STENCIL_BACK_WRITEMASK = 36005;
  int STENCIL_BITS = 3415;
  int STENCIL_BUFFER_BIT = 1024;
  int STENCIL_CLEAR_VALUE = 2961;
  int STENCIL_FAIL = 2964;
  int STENCIL_FUNC = 2962;

  /** @deprecated */
  int STENCIL_INDEX = 6401;
  int STENCIL_INDEX8 = 36168;
  int STENCIL_PASS_DEPTH_FAIL = 2965;
  int STENCIL_PASS_DEPTH_PASS = 2966;
  int STENCIL_REF = 2967;
  int STENCIL_TEST = 2960;
  int STENCIL_VALUE_MASK = 2963;
  int STENCIL_WRITEMASK = 2968;
  int STREAM_DRAW = 35040;
  int SUBPIXEL_BITS = 3408;
  int TEXTURE = 5890;
  int TEXTURE0 = 33984;
  int TEXTURE1 = 33985;
  int TEXTURE10 = 33994;
  int TEXTURE11 = 33995;
  int TEXTURE12 = 33996;
  int TEXTURE13 = 33997;
  int TEXTURE14 = 33998;
  int TEXTURE15 = 33999;
  int TEXTURE16 = 34000;
  int TEXTURE17 = 34001;
  int TEXTURE18 = 34002;
  int TEXTURE19 = 34003;
  int TEXTURE2 = 33986;
  int TEXTURE20 = 34004;
  int TEXTURE21 = 34005;
  int TEXTURE22 = 34006;
  int TEXTURE23 = 34007;
  int TEXTURE24 = 34008;
  int TEXTURE25 = 34009;
  int TEXTURE26 = 34010;
  int TEXTURE27 = 34011;
  int TEXTURE28 = 34012;
  int TEXTURE29 = 34013;
  int TEXTURE3 = 33987;
  int TEXTURE30 = 34014;
  int TEXTURE31 = 34015;
  int TEXTURE4 = 33988;
  int TEXTURE5 = 33989;
  int TEXTURE6 = 33990;
  int TEXTURE7 = 33991;
  int TEXTURE8 = 33992;
  int TEXTURE9 = 33993;
  int TEXTURE_2D = 3553;
  int TEXTURE_BINDING_2D = 32873;
  int TEXTURE_BINDING_CUBE_MAP = 34068;
  int TEXTURE_CUBE_MAP = 34067;
  int TEXTURE_CUBE_MAP_NEGATIVE_X = 34070;
  int TEXTURE_CUBE_MAP_NEGATIVE_Y = 34072;
  int TEXTURE_CUBE_MAP_NEGATIVE_Z = 34074;
  int TEXTURE_CUBE_MAP_POSITIVE_X = 34069;
  int TEXTURE_CUBE_MAP_POSITIVE_Y = 34071;
  int TEXTURE_CUBE_MAP_POSITIVE_Z = 34073;
  int TEXTURE_MAG_FILTER = 10240;
  int TEXTURE_MIN_FILTER = 10241;
  int TEXTURE_WRAP_S = 10242;
  int TEXTURE_WRAP_T = 10243;
  int TRIANGLES = 4;
  int TRIANGLE_FAN = 6;
  int TRIANGLE_STRIP = 5;
  int TRUE = 1;
  int UNPACK_ALIGNMENT = 3317;
  int UNSIGNED_BYTE = 5121;
  int UNSIGNED_INT = 5125;
  int UNSIGNED_SHORT = 5123;
  int UNSIGNED_SHORT_4_4_4_4 = 32819;
  int UNSIGNED_SHORT_5_5_5_1 = 32820;
  int UNSIGNED_SHORT_5_6_5 = 33635;
  int VALIDATE_STATUS = 35715;
  int VENDOR = 7936;
  int VERSION = 7938;
  int VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = 34975;
  int VERTEX_ATTRIB_ARRAY_ENABLED = 34338;
  int VERTEX_ATTRIB_ARRAY_NORMALIZED = 34922;
  int VERTEX_ATTRIB_ARRAY_POINTER = 34373;
  int VERTEX_ATTRIB_ARRAY_SIZE = 34339;
  int VERTEX_ATTRIB_ARRAY_STRIDE = 34340;
  int VERTEX_ATTRIB_ARRAY_TYPE = 34341;
  int VERTEX_SHADER = 35633;
  int VIEWPORT = 2978;
  int ZERO = 0;

  // OpenGL 3.0
  int ACTIVE_UNIFORM_BLOCKS = 35382;
  int ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH = 35381;
  int ALREADY_SIGNALED = 37146;
  int ANY_SAMPLES_PASSED = 35887;
  int ANY_SAMPLES_PASSED_CONSERVATIVE = 36202;
  int BLUE = 6405;
  int BUFFER_ACCESS_FLAGS = 37151;
  int BUFFER_MAPPED = 35004;
  int BUFFER_MAP_LENGTH = 37152;
  int BUFFER_MAP_OFFSET = 37153;
  int BUFFER_MAP_POINTER = 35005;
  int COLOR = 6144;
  int COLOR_ATTACHMENT1 = 36065;
  int COLOR_ATTACHMENT10 = 36074;
  int COLOR_ATTACHMENT11 = 36075;
  int COLOR_ATTACHMENT12 = 36076;
  int COLOR_ATTACHMENT13 = 36077;
  int COLOR_ATTACHMENT14 = 36078;
  int COLOR_ATTACHMENT15 = 36079;
  int COLOR_ATTACHMENT2 = 36066;
  int COLOR_ATTACHMENT3 = 36067;
  int COLOR_ATTACHMENT4 = 36068;
  int COLOR_ATTACHMENT5 = 36069;
  int COLOR_ATTACHMENT6 = 36070;
  int COLOR_ATTACHMENT7 = 36071;
  int COLOR_ATTACHMENT8 = 36072;
  int COLOR_ATTACHMENT9 = 36073;
  int COMPARE_REF_TO_TEXTURE = 34894;
  int COMPRESSED_R11_EAC = 37488;
  int COMPRESSED_RG11_EAC = 37490;
  int COMPRESSED_RGB8_ETC2 = 37492;
  int COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 37494;
  int COMPRESSED_RGBA8_ETC2_EAC = 37496;
  int COMPRESSED_SIGNED_R11_EAC = 37489;
  int COMPRESSED_SIGNED_RG11_EAC = 37491;
  int COMPRESSED_SRGB8_ALPHA8_ETC2_EAC = 37497;
  int COMPRESSED_SRGB8_ETC2 = 37493;
  int COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 = 37495;
  int CONDITION_SATISFIED = 37148;
  int COPY_READ_BUFFER = 36662;
  int COPY_READ_BUFFER_BINDING = 36662;
  int COPY_WRITE_BUFFER = 36663;
  int COPY_WRITE_BUFFER_BINDING = 36663;
  int CURRENT_QUERY = 34917;
  int DEPTH = 6145;
  int DEPTH24_STENCIL8 = 35056;
  int DEPTH32F_STENCIL8 = 36013;
  int DEPTH_COMPONENT24 = 33190;
  int DEPTH_COMPONENT32F = 36012;
  int DEPTH_STENCIL = 34041;
  int DEPTH_STENCIL_ATTACHMENT = 33306;
  int DRAW_BUFFER0 = 34853;
  int DRAW_BUFFER1 = 34854;
  int DRAW_BUFFER10 = 34863;
  int DRAW_BUFFER11 = 34864;
  int DRAW_BUFFER12 = 34865;
  int DRAW_BUFFER13 = 34866;
  int DRAW_BUFFER14 = 34867;
  int DRAW_BUFFER15 = 34868;
  int DRAW_BUFFER2 = 34855;
  int DRAW_BUFFER3 = 34856;
  int DRAW_BUFFER4 = 34857;
  int DRAW_BUFFER5 = 34858;
  int DRAW_BUFFER6 = 34859;
  int DRAW_BUFFER7 = 34860;
  int DRAW_BUFFER8 = 34861;
  int DRAW_BUFFER9 = 34862;
  int DRAW_FRAMEBUFFER = 36009;
  int DRAW_FRAMEBUFFER_BINDING = 36006;
  int DYNAMIC_COPY = 35050;
  int DYNAMIC_READ = 35049;
  int FLOAT_32_UNSIGNED_INT_24_8_REV = 36269;
  int FLOAT_MAT2x3 = 35685;
  int FLOAT_MAT2x4 = 35686;
  int FLOAT_MAT3x2 = 35687;
  int FLOAT_MAT3x4 = 35688;
  int FLOAT_MAT4x2 = 35689;
  int FLOAT_MAT4x3 = 35690;
  int FRAGMENT_SHADER_DERIVATIVE_HINT = 35723;
  int FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE = 33301;
  int FRAMEBUFFER_ATTACHMENT_BLUE_SIZE = 33300;
  int FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING = 33296;
  int FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE = 33297;
  int FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE = 33302;
  int FRAMEBUFFER_ATTACHMENT_GREEN_SIZE = 33299;
  int FRAMEBUFFER_ATTACHMENT_RED_SIZE = 33298;
  int FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE = 33303;
  int FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER = 36052;
  int FRAMEBUFFER_DEFAULT = 33304;
  int FRAMEBUFFER_INCOMPLETE_MULTISAMPLE = 36182;
  int FRAMEBUFFER_UNDEFINED = 33305;
  int GREEN = 6404;
  int HALF_FLOAT = 5131;
  int INTERLEAVED_ATTRIBS = 35980;
  int INT_2_10_10_10_REV = 36255;
  int INT_SAMPLER_2D = 36298;
  int INT_SAMPLER_2D_ARRAY = 36303;
  int INT_SAMPLER_3D = 36299;
  int INT_SAMPLER_CUBE = 36300;
  int INVALID_INDEX = -1;
  int MAJOR_VERSION = 33307;
  int MAP_FLUSH_EXPLICIT_BIT = 16;
  int MAP_INVALIDATE_BUFFER_BIT = 8;
  int MAP_INVALIDATE_RANGE_BIT = 4;
  int MAP_READ_BIT = 1;
  int MAP_UNSYNCHRONIZED_BIT = 32;
  int MAP_WRITE_BIT = 2;
  int MAX = 32776;
  int MAX_3D_TEXTURE_SIZE = 32883;
  int MAX_ARRAY_TEXTURE_LAYERS = 35071;
  int MAX_COLOR_ATTACHMENTS = 36063;
  int MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS = 35379;
  int MAX_COMBINED_UNIFORM_BLOCKS = 35374;
  int MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS = 35377;
  int MAX_DRAW_BUFFERS = 34852;
  int MAX_ELEMENTS_INDICES = 33001;
  int MAX_ELEMENTS_VERTICES = 33000;
  int MAX_ELEMENT_INDEX = 36203;
  int MAX_FRAGMENT_INPUT_COMPONENTS = 37157;
  int MAX_FRAGMENT_UNIFORM_BLOCKS = 35373;
  int MAX_FRAGMENT_UNIFORM_COMPONENTS = 35657;
  int MAX_PROGRAM_TEXEL_OFFSET = 35077;
  int MAX_SAMPLES = 36183;
  int MAX_SERVER_WAIT_TIMEOUT = 37137;
  int MAX_TEXTURE_LOD_BIAS = 34045;
  int MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS = 35978;
  int MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS = 35979;
  int MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS = 35968;
  int MAX_UNIFORM_BLOCK_SIZE = 35376;
  int MAX_UNIFORM_BUFFER_BINDINGS = 35375;
  int MAX_VARYING_COMPONENTS = 35659;
  int MAX_VERTEX_OUTPUT_COMPONENTS = 37154;
  int MAX_VERTEX_UNIFORM_BLOCKS = 35371;
  int MAX_VERTEX_UNIFORM_COMPONENTS = 35658;
  int MIN = 32775;
  int MINOR_VERSION = 33308;
  int MIN_PROGRAM_TEXEL_OFFSET = 35076;
  int NUM_EXTENSIONS = 33309;
  int NUM_PROGRAM_BINARY_FORMATS = 34814;
  int NUM_SAMPLE_COUNTS = 37760;
  int OBJECT_TYPE = 37138;
  int PACK_ROW_LENGTH = 3330;
  int PACK_SKIP_PIXELS = 3332;
  int PACK_SKIP_ROWS = 3331;
  int PIXEL_PACK_BUFFER = 35051;
  int PIXEL_PACK_BUFFER_BINDING = 35053;
  int PIXEL_UNPACK_BUFFER = 35052;
  int PIXEL_UNPACK_BUFFER_BINDING = 35055;
  int PRIMITIVE_RESTART_FIXED_INDEX = 36201;
  int PROGRAM_BINARY_FORMATS = 34815;
  int PROGRAM_BINARY_LENGTH = 34625;
  int PROGRAM_BINARY_RETRIEVABLE_HINT = 33367;
  int QUERY_RESULT = 34918;
  int QUERY_RESULT_AVAILABLE = 34919;
  int R11F_G11F_B10F = 35898;
  int R16F = 33325;
  int R16I = 33331;
  int R16UI = 33332;
  int R32F = 33326;
  int R32I = 33333;
  int R32UI = 33334;
  int R8 = 33321;
  int R8I = 33329;
  int R8UI = 33330;
  int R8_SNORM = 36756;
  int RASTERIZER_DISCARD = 35977;
  int READ_BUFFER = 3074;
  int READ_FRAMEBUFFER = 36008;
  int READ_FRAMEBUFFER_BINDING = 36010;
  int RED = 6403;
  int RED_INTEGER = 36244;
  int RENDERBUFFER_SAMPLES = 36011;
  int RG = 33319;
  int RG16F = 33327;
  int RG16I = 33337;
  int RG16UI = 33338;
  int RG32F = 33328;
  int RG32I = 33339;
  int RG32UI = 33340;
  int RG8 = 33323;
  int RG8I = 33335;
  int RG8UI = 33336;
  int RG8_SNORM = 36757;
  int RGB10_A2 = 32857;
  int RGB10_A2UI = 36975;
  int RGB16F = 34843;
  int RGB16I = 36233;
  int RGB16UI = 36215;
  int RGB32F = 34837;
  int RGB32I = 36227;
  int RGB32UI = 36209;
  int RGB8 = 32849;
  int RGB8I = 36239;
  int RGB8UI = 36221;
  int RGB8_SNORM = 36758;
  int RGB9_E5 = 35901;
  int RGBA16F = 34842;
  int RGBA16I = 36232;
  int RGBA16UI = 36214;
  int RGBA32F = 34836;
  int RGBA32I = 36226;
  int RGBA32UI = 36208;
  int RGBA8 = 32856;
  int RGBA8I = 36238;
  int RGBA8UI = 36220;
  int RGBA8_SNORM = 36759;
  int RGBA_INTEGER = 36249;
  int RGB_INTEGER = 36248;
  int RG_INTEGER = 33320;
  int SAMPLER_2D_ARRAY = 36289;
  int SAMPLER_2D_ARRAY_SHADOW = 36292;
  int SAMPLER_2D_SHADOW = 35682;
  int SAMPLER_3D = 35679;
  int SAMPLER_BINDING = 35097;
  int SAMPLER_CUBE_SHADOW = 36293;
  int SEPARATE_ATTRIBS = 35981;
  int SIGNALED = 37145;
  int SIGNED_NORMALIZED = 36764;
  int SRGB = 35904;
  int SRGB8 = 35905;
  int SRGB8_ALPHA8 = 35907;
  int STATIC_COPY = 35046;
  int STATIC_READ = 35045;
  int STENCIL = 6146;
  int STREAM_COPY = 35042;
  int STREAM_READ = 35041;
  int SYNC_CONDITION = 37139;
  int SYNC_FENCE = 37142;
  int SYNC_FLAGS = 37141;
  int SYNC_FLUSH_COMMANDS_BIT = 1;
  int SYNC_GPU_COMMANDS_COMPLETE = 37143;
  int SYNC_STATUS = 37140;
  int TEXTURE_2D_ARRAY = 35866;
  int TEXTURE_3D = 32879;
  int TEXTURE_BASE_LEVEL = 33084;
  int TEXTURE_BINDING_2D_ARRAY = 35869;
  int TEXTURE_BINDING_3D = 32874;
  int TEXTURE_COMPARE_FUNC = 34893;
  int TEXTURE_COMPARE_MODE = 34892;
  int TEXTURE_IMMUTABLE_FORMAT = 37167;
  int TEXTURE_IMMUTABLE_LEVELS = 33503;
  int TEXTURE_MAX_LEVEL = 33085;
  int TEXTURE_MAX_LOD = 33083;
  int TEXTURE_MIN_LOD = 33082;
  int TEXTURE_SWIZZLE_A = 36421;
  int TEXTURE_SWIZZLE_B = 36420;
  int TEXTURE_SWIZZLE_G = 36419;
  int TEXTURE_SWIZZLE_R = 36418;
  int TEXTURE_WRAP_R = 32882;
  int TIMEOUT_EXPIRED = 37147;
  int TIMEOUT_IGNORED = -1;
  int TRANSFORM_FEEDBACK = 36386;
  int TRANSFORM_FEEDBACK_ACTIVE = 36388;
  int TRANSFORM_FEEDBACK_BINDING = 36389;
  int TRANSFORM_FEEDBACK_BUFFER = 35982;
  int TRANSFORM_FEEDBACK_BUFFER_BINDING = 35983;
  int TRANSFORM_FEEDBACK_BUFFER_MODE = 35967;
  int TRANSFORM_FEEDBACK_BUFFER_SIZE = 35973;
  int TRANSFORM_FEEDBACK_BUFFER_START = 35972;
  int TRANSFORM_FEEDBACK_PAUSED = 36387;
  int TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN = 35976;
  int TRANSFORM_FEEDBACK_VARYINGS = 35971;
  int TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH = 35958;
  int UNIFORM_ARRAY_STRIDE = 35388;
  int UNIFORM_BLOCK_ACTIVE_UNIFORMS = 35394;
  int UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES = 35395;
  int UNIFORM_BLOCK_BINDING = 35391;
  int UNIFORM_BLOCK_DATA_SIZE = 35392;
  int UNIFORM_BLOCK_INDEX = 35386;
  int UNIFORM_BLOCK_NAME_LENGTH = 35393;
  int UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER = 35398;
  int UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER = 35396;
  int UNIFORM_BUFFER = 35345;
  int UNIFORM_BUFFER_BINDING = 35368;
  int UNIFORM_BUFFER_OFFSET_ALIGNMENT = 35380;
  int UNIFORM_BUFFER_SIZE = 35370;
  int UNIFORM_BUFFER_START = 35369;
  int UNIFORM_IS_ROW_MAJOR = 35390;
  int UNIFORM_MATRIX_STRIDE = 35389;
  int UNIFORM_NAME_LENGTH = 35385;
  int UNIFORM_OFFSET = 35387;
  int UNIFORM_SIZE = 35384;
  int UNIFORM_TYPE = 35383;
  int UNPACK_IMAGE_HEIGHT = 32878;
  int UNPACK_ROW_LENGTH = 3314;
  int UNPACK_SKIP_IMAGES = 32877;
  int UNPACK_SKIP_PIXELS = 3316;
  int UNPACK_SKIP_ROWS = 3315;
  int UNSIGNALED = 37144;
  int UNSIGNED_INT_10F_11F_11F_REV = 35899;
  int UNSIGNED_INT_24_8 = 34042;
  int UNSIGNED_INT_2_10_10_10_REV = 33640;
  int UNSIGNED_INT_5_9_9_9_REV = 35902;
  int UNSIGNED_INT_SAMPLER_2D = 36306;
  int UNSIGNED_INT_SAMPLER_2D_ARRAY = 36311;
  int UNSIGNED_INT_SAMPLER_3D = 36307;
  int UNSIGNED_INT_SAMPLER_CUBE = 36308;
  int UNSIGNED_INT_VEC2 = 36294;
  int UNSIGNED_INT_VEC3 = 36295;
  int UNSIGNED_INT_VEC4 = 36296;
  int UNSIGNED_NORMALIZED = 35863;
  int VERTEX_ARRAY_BINDING = 34229;
  int VERTEX_ATTRIB_ARRAY_DIVISOR = 35070;
  int VERTEX_ATTRIB_ARRAY_INTEGER = 35069;
  int WAIT_FAILED = 37149;

  int UNPACK_FLIP_Y_WEBGL = 0x9240;
  int UNPACK_PREMULTIPLY_ALPHA_WEBGL = 0x9241;
  int UNPACK_COLORSPACE_CONVERSION_WEBGL = 0x9243;
}

