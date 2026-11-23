// ---------------------------------------------------------------------------
// Author:      Robert Roebling
// Created:     2026-03-01 (wxDart Web: 2026-11-15)
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
    _depth = 16;
    _sampleBuffers = 1;
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
    _depth = val;
  }

  void stencil( int val ) {
    _stencil = val;
  }

  void sampleBuffers( int val ) {
    _sampleBuffers = val;
  }

  void samplers( int val ) {
  }

  void endList( ) {
  }

  // wxDart Web: used for the WebGL context
  int _depth = 16;
  int _stencil = 0;
  int _sampleBuffers = 1;
}

// ------------------------- WebGL 2 binding (wxDart Web) ----------------------

@JS('wxc.glContext')
external _GL? _jsGlContext(int id, bool depth, bool stencil, bool antialias);

extension type _GLActiveInfoJs._(JSObject _) implements JSObject {
  external int get type;
  external String get name;
  external int get size;
}

extension type _GLPrecisionJs._(JSObject _) implements JSObject {
  external int get precision;
  external int get rangeMin;
  external int get rangeMax;
}

/// The browser's WebGL2RenderingContext
extension type _GL._(JSObject _) implements JSObject {
  external int get drawingBufferWidth;
  external int get drawingBufferHeight;
  external void scissor(int x, int y, int w, int h);
  external void viewport(int x, int y, int w, int h);
  external _GLPrecisionJs? getShaderPrecisionFormat(int shaderType, int precisionType);
  external JSObject? getExtension(String name);
  external JSArray<JSString>? getSupportedExtensions();
  external JSAny? getParameter(int key);
  external JSObject? createTexture();
  external void bindTexture(int target, JSObject? texture);
  external void activeTexture(int texture);
  external void texParameteri(int target, int pname, int param);
  external void texParameterf(int target, int pname, double param);
  external void texImage2D(int target, int level, int internalformat, int width, int height, int border,
      int format, int type, JSObject? pixels);
  external void texImage3D(int target, int level, int internalformat, int width, int height, int depth, int border,
      int format, int type, JSObject? pixels);
  external void texSubImage2D(int target, int level, int x, int y, int width, int height, int format, int type,
      JSObject? pixels);
  external void texSubImage3D(int target, int level, int x, int y, int z, int width, int height, int depth,
      int format, int type, JSObject? pixels);
  external void compressedTexImage2D(int target, int level, int internalformat, int width, int height, int border,
      JSObject? data);
  external void compressedTexImage3D(int target, int level, int internalformat, int width, int height, int depth,
      int border, JSObject? data);
  external void compressedTexSubImage2D(int target, int level, int x, int y, int width, int height, int format,
      JSObject? data);
  external void compressedTexSubImage3D(int target, int level, int x, int y, int z, int width, int height, int depth,
      int format, JSObject? data);
  external void copyTexImage2D(int target, int level, int internalformat, int x, int y, int width, int height, int border);
  external void copyTexSubImage2D(int target, int level, int xOffset, int yOffset, int x, int y, int width, int height);
  external void copyTexSubImage3D(int target, int level, int xOffset, int yOffset, int zOffset, int x, int y,
      int width, int height);
  external void texStorage2D(int target, int levels, int internalformat, int width, int height);
  external void texStorage3D(int target, int levels, int internalformat, int width, int height, int depth);
  external void generateMipmap(int target);
  external void deleteTexture(JSObject? texture);
  external void pixelStorei(int pname, int param);
  external void depthFunc(int func);
  external void depthMask(bool flag);
  external void enable(int cap);
  external void disable(int cap);
  external void blendEquation(int mode);
  external void blendEquationSeparate(int modeRGB, int modeAlpha);
  external void blendFunc(int sfactor, int dfactor);
  external void blendFuncSeparate(int srcRGB, int dstRGB, int srcAlpha, int dstAlpha);
  external void frontFace(int mode);
  external void cullFace(int mode);
  external void lineWidth(double width);
  external void polygonOffset(double factor, double units);
  external void stencilMask(int mask);
  external void stencilFunc(int func, int ref, int mask);
  external void stencilOp(int fail, int zfail, int zpass);
  external void clearStencil(int s);
  external void clearDepth(double depth);
  external void colorMask(bool r, bool g, bool b, bool a);
  external void clearColor(double r, double g, double b, double a);
  external void clear(int mask);
  external JSObject? getContextAttributes();
  external JSObject? createProgram();
  external void deleteProgram(JSObject? program);
  external bool isProgram(JSObject? program);
  external void attachShader(JSObject? program, JSObject? shader);
  external void bindAttribLocation(JSObject? program, int index, String name);
  external void linkProgram(JSObject? program);
  external void useProgram(JSObject? program);
  external JSAny? getProgramParameter(JSObject? program, int pname);
  external String? getProgramInfoLog(JSObject? program);
  external int getUniformBlockIndex(JSObject? program, String name);
  external void uniformBlockBinding(JSObject? program, int index, int binding);
  external _GLActiveInfoJs? getActiveUniform(JSObject? program, int index);
  external _GLActiveInfoJs? getActiveAttrib(JSObject? program, int index);
  external JSObject? getUniformLocation(JSObject? program, String name);
  external int getAttribLocation(JSObject? program, String name);
  external JSObject? createShader(int type);
  external void deleteShader(JSObject? shader);
  external void shaderSource(JSObject? shader, String source);
  external void compileShader(JSObject? shader);
  external JSAny? getShaderParameter(JSObject? shader, int pname);
  external String? getShaderInfoLog(JSObject? shader);
  external String? getShaderSource(JSObject? shader);
  external JSObject? createBuffer();
  external void deleteBuffer(JSObject? buffer);
  external void bindBuffer(int target, JSObject? buffer);
  external void bindBufferBase(int target, int index, JSObject? buffer);
  external void bufferData(int target, JSObject? data, int usage);
  @JS('bufferData')
  external void bufferDataSize(int target, int size, int usage);
  external void bufferSubData(int target, int offset, JSObject? data);
  external void clearBufferiv(int buffer, int drawbuffer, JSInt32Array values);
  external void clearBufferuiv(int buffer, int drawbuffer, JSUint32Array values);
  external JSObject? createVertexArray();
  external void deleteVertexArray(JSObject? vao);
  external void bindVertexArray(JSObject? vao);
  external void enableVertexAttribArray(int index);
  external void disableVertexAttribArray(int index);
  external void vertexAttribPointer(int index, int size, int type, bool normalized, int stride, int offset);
  external void vertexAttribIPointer(int index, int size, int type, int stride, int offset);
  external void vertexAttribDivisor(int index, int divisor);
  external void vertexAttrib1fv(int index, JSFloat32Array values);
  external void vertexAttrib2fv(int index, JSFloat32Array values);
  external void vertexAttrib3fv(int index, JSFloat32Array values);
  external void vertexAttrib4fv(int index, JSFloat32Array values);
  external void drawArrays(int mode, int first, int count);
  external void drawArraysInstanced(int mode, int first, int count, int instanceCount);
  external void drawElements(int mode, int count, int type, int offset);
  external void drawElementsInstanced(int mode, int count, int type, int offset, int instanceCount);
  external void drawBuffers(JSAny buffers);
  external JSObject? createFramebuffer();
  external void deleteFramebuffer(JSObject? framebuffer);
  external void bindFramebuffer(int target, JSObject? framebuffer);
  external int checkFramebufferStatus(int target);
  external void framebufferTexture2D(int target, int attachment, int textarget, JSObject? texture, int level);
  external void framebufferTextureLayer(int target, int attachment, JSObject? texture, int level, int layer);
  external void framebufferRenderbuffer(int target, int attachment, int renderbuffertarget, JSObject? renderbuffer);
  external void blitFramebuffer(int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1,
      int mask, int filter);
  external void invalidateFramebuffer(int target, JSAny attachments);
  external JSObject? createRenderbuffer();
  external void deleteRenderbuffer(JSObject? renderbuffer);
  external void bindRenderbuffer(int target, JSObject? renderbuffer);
  external void renderbufferStorage(int target, int internalformat, int width, int height);
  external void renderbufferStorageMultisample(int target, int samples, int internalformat, int width, int height);
  external void readPixels(int x, int y, int width, int height, int format, int type, JSObject? pixels);
  external void uniform1i(JSObject? location, int x);
  external void uniform1ui(JSObject? location, int x);
  external void uniform1f(JSObject? location, double x);
  external void uniform2f(JSObject? location, double x, double y);
  external void uniform3f(JSObject? location, double x, double y, double z);
  external void uniform4f(JSObject? location, double x, double y, double z, double w);
  external void uniform1fv(JSObject? location, JSFloat32Array values);
  external void uniform2fv(JSObject? location, JSFloat32Array values);
  external void uniform3fv(JSObject? location, JSFloat32Array values);
  external void uniform4fv(JSObject? location, JSFloat32Array values);
  external void uniform1iv(JSObject? location, JSInt32Array values);
  external void uniform2iv(JSObject? location, JSInt32Array values);
  external void uniform3iv(JSObject? location, JSInt32Array values);
  external void uniform4iv(JSObject? location, JSInt32Array values);
  external void uniform1uiv(JSObject? location, JSUint32Array values);
  external void uniform2uiv(JSObject? location, JSUint32Array values);
  external void uniform3uiv(JSObject? location, JSUint32Array values);
  external void uniform4uiv(JSObject? location, JSUint32Array values);
  external void uniformMatrix2fv(JSObject? location, bool transpose, JSFloat32Array values);
  external void uniformMatrix3fv(JSObject? location, bool transpose, JSFloat32Array values);
  external void uniformMatrix4fv(JSObject? location, bool transpose, JSFloat32Array values);
  external JSObject? createTransformFeedback();
  external void deleteTransformFeedback(JSObject? tf);
  external bool isTransformFeedback(JSObject? tf);
  external void bindTransformFeedback(int target, JSObject? tf);
  external void transformFeedbackVaryings(JSObject? program, JSArray<JSString> varyings, int bufferMode);
  external void beginTransformFeedback(int primitiveMode);
  external void endTransformFeedback();
  external void pauseTransformFeedback();
  external void resumeTransformFeedback();
  external _GLActiveInfoJs? getTransformFeedbackVarying(JSObject? program, int index);
  external int getError();
  external void flush();
  external void finish();
}

/// Converts typed data to the JS typed array WebGL expects (no copy in dart2js)
JSObject? _glView( TypedData? data ) {
  if (data == null) return null;
  if (data is Float32List) return data.toJS;
  if (data is Uint8List) return data.toJS;
  if (data is Uint16List) return data.toJS;
  if (data is Uint32List) return data.toJS;
  if (data is Int32List) return data.toJS;
  if (data is Int16List) return data.toJS;
  if (data is Int8List) return data.toJS;
  if (data is Uint8ClampedList) return data.toJS;
  if (data is Float64List) return data.toJS;
  return data.buffer.asUint8List( data.offsetInBytes, data.lengthInBytes ).toJS;
}

/// Converts a WebGL parameter value (number, boolean, ...) to Dart
dynamic _glToDart( JSAny? value ) {
  if (value == null) return null;
  if (value.typeofEquals( 'boolean' )) return (value as JSBoolean).toDart;
  if (value.typeofEquals( 'number' )) {
    final d = (value as JSNumber).toDartDouble;
    return d == d.truncateToDouble() ? d.toInt() : d;
  }
  if (value.typeofEquals( 'string' )) return (value as JSString).toDart;
  return value;
}

// ------------------------- wxGLCanvas ----------------------

/// Represents an OpenGL/OpenGL ES/WebGL surface.
/// 
/// Use together with [WxGLContext].
/// 
/// Main interface
/// * [setCurrent]
/// * [swapBuffers]
/// 
/// Example usage:
///```dart
///   // in parent window's constructor
///   {
///     final attr = WxGLAttributes();
///     attr.defaults();
///     attr.endList();
///     _glCanvas = MyGLCanvas(this,attr);
///   }
///
/// class MyGLCanvas extends WxGLCanvas
/// {
///   MyGLCanvas( WxWindow parent, WxGLAttributes attr ) : super( parent, attr, -1 )
///   {
///     final attrs = WxGLContextAttrs();
///     if (wxIsMac() && !wxUsesFlutter()) {
///       // enable OpenGL 4.1 on macOS in wxDart Native
///       attrs.forwardCompatible();
///       attrs.coreProfile();
///     }
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
///     // Render into this canvas from now on, but test
///     // for failure - typically when called too soon
///     // in window creation process
///     if (!setCurrent(_glContext)) {
///       return;
///     }
/// 
///     final size = getClientSize();
///     if ((size.x < 2) || (size.y < 2)) {
///       // The window has not been given a size yet
///       return;
///     }
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
  /// Creates the canvas. In wxDart Web, the WebGL 2 context is created
  /// immediately; the drawing buffer has the size of the window (one pixel
  /// per DIP as in wxDart Flutter) and is cleared when the window is
  /// resized, so redraw in a [WxSizeEvent] handler.
  WxGLCanvas( WxWindow parent, WxGLAttributes dispAttrs, int id, { WxPoint pos = wxDefaultPosition, WxSize size = wxDefaultSize, int style = 0 } ) 
  : super( parent, id, pos, size, style )
  {
    _gl = _jsGlContext( _handle, dispAttrs._depth > 0, dispAttrs._stencil > 0, dispAttrs._sampleBuffers > 0 );
    if (_gl == null) {
      wxLogError( "WebGL 2 is not available in this browser." );
    }
  }

  @override
  String get _jsKind => 'glcanvas';

  _GL? _gl;
  WxGLContext? _context;

  /// Swap buffers after drawing is completed
  /// 
  /// In wxDart Web, the browser shows the result after the current event
  /// has been processed; this only flushes the GL command queue.
  void swapBuffers()
  {
    _gl?.flush();
  }

  /// Makes [context] use this canvas to draw into
  /// 
  /// return true on success
  bool setCurrent( WxGLContext context )
  {
    _context = context;
    context._gl = _gl;
    return _gl != null;
  }
}

// ------------------------- wxGLContext ----------------------

/// Common base of the handles of GL objects (wxDart Web)
class _WxGlHandle {
  _WxGlHandle( this.id ) : _js = null;
  _WxGlHandle._fromJs( JSObject? object ) : id = object, _js = object;

  /// The WebGL object (or an index, e.g. for attribute locations)
  final dynamic id;

  /// The WebGL object, typed for passing it back to WebGL
  final JSObject? _js;
}

/// Helper class to hold the reference to an OpenGL buffer
/// 
/// Used by [WxGLContext]
class WxGlBuffer extends _WxGlHandle {
  /// Used internally
  WxGlBuffer(super.id);
  WxGlBuffer._fromJs(super.object) : super._fromJs();

  /// Returns ID of the buffer
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL render buffer
/// 
/// Used by [WxGLContext]
class WxGlRenderbuffer extends _WxGlHandle {
  /// Used internally
  WxGlRenderbuffer(super.id);
  WxGlRenderbuffer._fromJs(super.object) : super._fromJs();

  /// Returns ID of the render buffer
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL texture
/// 
/// Used by [WxGLContext]
class WxGlTexture extends _WxGlHandle {
  /// Used internally
  WxGlTexture(super.id);
  WxGlTexture._fromJs(super.object) : super._fromJs();

  /// Returns ID of the texture
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL vertex array object
/// 
/// Used by [WxGLContext]
class WxGlVertexArrayObject extends _WxGlHandle {
  /// Used internally
  WxGlVertexArrayObject(super.id);
  WxGlVertexArrayObject._fromJs(super.object) : super._fromJs();

  /// Returns ID of the vertex array object
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL program
/// 
/// Used by [WxGLContext]
class WxGlProgram extends _WxGlHandle {
  /// Used internally
  WxGlProgram(super.id);
  WxGlProgram._fromJs(super.object) : super._fromJs();

  /// Returns ID of the GL program
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL shader
/// 
/// Used by [WxGLContext]
class WxGlShader extends _WxGlHandle {
  /// Used internally
  WxGlShader(super.id);
  WxGlShader._fromJs(super.object) : super._fromJs();

  /// Returns ID of the shader
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL frame buffer
/// 
/// Used by [WxGLContext]
class WxGlFramebuffer extends _WxGlHandle {
  /// Used internally
  WxGlFramebuffer(super.id);
  WxGlFramebuffer._fromJs(super.object) : super._fromJs();

  /// Returns ID of the frame buffer
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL location
///
/// Used by [WxGLContext]
class WxGlUniformLocation extends _WxGlHandle {
  /// Used internally
  WxGlUniformLocation(super.id);
  WxGlUniformLocation._fromJs(super.object) : super._fromJs();

  /// Returns ID of the location
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL transform feedback
/// 
/// Used by [WxGLContext]
class WxGlTransformFeedback extends _WxGlHandle {
  /// Used internally
  WxGlTransformFeedback(super.id);
  WxGlTransformFeedback._fromJs(super.object) : super._fromJs();

  /// Returns ID of the transform feedback
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL active info structure
///
/// Used by [WxGLContext]
class WxGlActiveInfo {
  /// Used internally
  WxGlActiveInfo( this._type, this._name, this._size );

  final int _type;
  final String _name;
  final int _size;

  /// returns the type
  int getType() {
    return _type;
  }

  /// returns the name
  String getName() {
    return _name;
  }

  /// returns the size
  int getSize() {
    return _size;
  }
}

/// Helper class to hold the reference to an OpenGL parameter
///
/// Used by [WxGLContext]
class WxGlParameter extends _WxGlHandle {
  /// Used internally
  WxGlParameter(super.id);

  /// Returns ID of the parameter
  dynamic getId() { return id; }
}

/// Helper class to hold the reference to an OpenGL shader precision format
///
/// Used by [WxGLContext]
class WxGlShaderPrecisionFormat {
  /// Used internally
  WxGlShaderPrecisionFormat( this._precision, this._rangeMin, this._rangeMax );

  final int _precision;
  final int _rangeMin;
  final int _rangeMax;

  /// Returns precision
  int getPrecision() {
    return _precision;
  }

  /// Returns min of range
  int getMin() {
    return _rangeMin;
  }

  /// Returns max of range
  int getMax() {
    return _rangeMax;
  }
}

WxGlActiveInfo _glInfo( _GLActiveInfoJs? info ) {
  if (info == null) return WxGlActiveInfo( 0, "", 0 );
  return WxGlActiveInfo( info.type, info.name, info.size );
}

/// Represents an OpenGL ES/WebGL rendering context for use with [WxGLCanvas].
/// 
/// [WxGLContext] mirrors the API implemented from the  flutter_angle project
/// which in turn
/// uses the ANGLE libary to draw directly into a flutter surface. In wxDart
/// Web, it calls the browser's WebGL 2 API directly. In wxDart
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
///     gl.bindBuffer(WebGL.ARRAY_BUFFER, _triangleVertexBuffer); 
///     gl.bufferData(WebGL.ARRAY_BUFFER, vertices, WebGL.STATIC_DRAW);
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
  /// 
  /// In wxDart Web, [onPrepare] is called right after the constructors have
  /// run (in a microtask), followed by a [WxSizeEvent] for the canvas so
  /// that the app draws its first picture.
  WxGLContext( WxGLCanvas canvas, WxGLContextAttrs attr ) {
    _gl = canvas._gl;
    canvas._context = this;
    scheduleMicrotask( () {
      if (_isPrepared || canvas._gl == null || canvas._isDestroyed) return;
      _gl = canvas._gl;
      _isPrepared = true;
      onPrepare();
      canvas._sendSizeEvent();
      _scheduleIdle();
    } );
  }

  _GL? _gl;
  bool _isPrepared = false;

  _GL get _g {
    final gl = _gl;
    if (gl == null) throw StateError( "WxGLContext: WebGL is not available" );
    return gl;
  }

  /// Must be overrridden. Set up your context in this method which
  /// will get called immediately in wxDart Native and delayed in
  /// wxDart Flutter
  ///
  /// Must be overrridden. Set up your context in this method which
  /// will get called immediately in wxDart Native and delayed in
  /// wxDart Flutter and wxDart Web
  void onPrepare();

  /// Returns true if the context has been set up and can be drawn into
  bool isOK( ) {
    return _gl != null;
  }

  int getWidth() {
    if (_gl == null) return -1;
    return _gl!.drawingBufferWidth;
  }

  int getHeight() {
    if (_gl == null) return -1;
    return _gl!.drawingBufferHeight;
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
    _g.scissor(x,y,z,w);
  }

  void viewport(int x, int y, int width, int height) {
    _g.viewport(x,y,width,height);
  }

  WxGlShaderPrecisionFormat getShaderPrecisionFormat( int shaderType, int precisionType) {
    final res = _g.getShaderPrecisionFormat(shaderType,precisionType);
    if (res == null) return WxGlShaderPrecisionFormat( 0, 0, 0 );
    return WxGlShaderPrecisionFormat( res.precision, res.rangeMin, res.rangeMax );
  }

  Object? getExtension(String key) {
    return _g.getExtension(key);
  }

  Object? getExtensionDesktop(String key) {
    return _g.getExtension(key);
  }

  /// Returns the GL string for [key], e.g. WebGL.VERSION or
  /// WebGL.SHADING_LANGUAGE_VERSION (which contains "ES" in WebGL).
  /// WebGL.EXTENSIONS returns the supported extensions separated by spaces.
  String getString(int key)
  {
    if (key == WebGL.EXTENSIONS) {
      final list = _g.getSupportedExtensions();
      return list == null ? "" : list.toDart.map( (s) => s.toDart ).join(" ");
    }
    final value = _glToDart( _g.getParameter( key ) );
    return value is String ? value : "unnamed";
  }

  /// Returns an integer parameter (booleans are returned as 1 or 0)
  int getParameter(int key) {
    final value = _glToDart( _g.getParameter( key ) );
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    return 0;
  }

  WxGlTexture createTexture() { 
    return WxGlTexture._fromJs( _g.createTexture() );
  }

  void bindTexture(int type, WxGlTexture? texture) {
    _g.bindTexture( type, texture?._js );
  }

  void bindTexture2(WxGlTexture texture) {
    _g.bindTexture( WebGL.TEXTURE_2D, texture._js );
  }

  void activeTexture(int v0) {
    _g.activeTexture( v0 );
  }

  void texParameteri(int v0, int v1, int v2) {
    _g.texParameteri( v0, v1, v2 );
  }

  void texImage2D(int target, int level, int internalformat, int width,
      int height, int border, int format, int type, TypedData? pixels) {
    _g.texImage2D( target, level, internalformat, width, height, border, format, type, _glView(pixels) );
  }

  void texImage2D_NOSIZE(
      int target, int level, int internalformat, int format, int type, TypedData? pixels) {
    wxLogError( "texImage2D_NOSIZE not implemented" );
  }

  void texImage3D(int target, int level, int internalformat, int width,
      int height, int depth, int border, int format, int type, TypedData? pixels ) {
    _g.texImage3D( target, level, internalformat, width, height, depth, border, format, type, _glView(pixels) );
  }

  void depthFunc(int v0) {
    _g.depthFunc( v0);
  }

  void depthMask(bool v0) {
    _g.depthMask( v0);
  }

  void enable(int v0) {
    _g.enable( v0);
  }

  void disable(int v0) {
    _g.disable( v0);
  }

  void blendEquation(int v0) {
    _g.blendEquation( v0);
  }

  void useProgram(WxGlProgram? program) {
    _g.useProgram( program?._js );
  }

  void blendFuncSeparate(int v0, int v1, int v2, int v3) {
    _g.blendFuncSeparate( v0, v1, v2, v3 );
  }

  void blendFunc(int v0, int v1) {
    _g.blendFunc( v0, v1 );
  }

  void blendEquationSeparate(int var0, int var1) {
    _g.blendEquationSeparate( var0, var1 );
  }

  void frontFace(int v0) {
    _g.frontFace( v0 );
  }

  void cullFace(int mode) {
    _g.cullFace( mode );
  }

  void lineWidth(double width) {
    _g.lineWidth( width );
  }

  void polygonOffset(double v0, double v1) {
    _g.polygonOffset( v0, v1 );
  }

  void stencilMask(int mask) {
    _g.stencilMask(mask);
  }

  void stencilFunc(int func, int ref, int mask) {
    _g.stencilFunc(func, ref, mask);
  }

  void stencilOp(int fail, int zfail, int zpass) {
    _g.stencilOp(fail, zfail, zpass);
  }

  void clearStencil(int s) {
    _g.clearStencil( s );
  }

  void clearDepth(double v0) {
    _g.clearDepth( v0 );
  }

  void colorMask(bool v0, bool v1, bool v2, bool v3) {
    _g.colorMask( v0, v1, v2, v3 );
  }

  void clearColor(double r, double g, double b, double a) {
    _g.clearColor( r, g, b, a );
  }

  void compressedTexImage2D(int target, int level, int internalformat,
      int width, int height, int border, TypedData? data) {
    _g.compressedTexImage2D( target, level, internalformat, width, height, border, _glView(data) );
  }

  void compressedTexImage3D(int target, int level, int internalformat,
      int width, int height, int depth, int border, TypedData? data) {
    _g.compressedTexImage3D( target, level, internalformat, width, height, depth, border, _glView(data) );
  }

  void generateMipmap(int v0) { 
    _g.generateMipmap( v0 );
  }

  void deleteTexture(WxGlTexture v0) { 
    _g.deleteTexture( v0._js );
  }

  void deleteFramebuffer(WxGlFramebuffer v0) { 
    _g.deleteFramebuffer( v0._js );
  }

  void deleteRenderbuffer(WxGlRenderbuffer v0) { 
    _g.deleteRenderbuffer( v0._js );
  }

  void texParameterf(int target, int pname, double param) {
    _g.texParameterf( target, pname, param );
  }

  void pixelStorei(int v0, int v1) {
    _g.pixelStorei( v0, v1 );
  }

  dynamic getContextAttributes() {
    return _g.getContextAttributes();
  }

  WxGlParameter getProgramParameter(WxGlProgram program, int pname) {
    return WxGlParameter( _glToDart( _g.getProgramParameter( program._js, pname ) ) );
  }

  int getUniformBlockIndex( WxGlProgram program, String name ) {
    return _g.getUniformBlockIndex( program._js, name );
  }

  void uniformBlockBinding( WxGlProgram program, int uniformBlockIndex, int uniformBlockBinding ) {
    _g.uniformBlockBinding( program._js, uniformBlockIndex, uniformBlockBinding );
  }

  WxGlActiveInfo getActiveUniform(WxGlProgram program, int v1) {
    return _glInfo( _g.getActiveUniform( program._js, v1 ) );
  }

  WxGlActiveInfo getActiveAttrib(WxGlProgram program, int v1) {
    return _glInfo( _g.getActiveAttrib( program._js, v1 ) );
  }

  WxGlUniformLocation getUniformLocation(WxGlProgram program, String name) {
    return WxGlUniformLocation._fromJs( _g.getUniformLocation( program._js, name ) );
  }

  void clear(int v0) {
    _g.clear( v0 );
  }

  WxGlBuffer createBuffer() {
    return WxGlBuffer._fromJs( _g.createBuffer() );
  }

  void deleteBuffer(WxGlBuffer v0) {
    _g.deleteBuffer( v0._js );
  }

  void bindBuffer(int v0, WxGlBuffer? v1) {
    _g.bindBuffer( v0, v1?._js );
  }

  void bufferData(int target, TypedData data, int? usage) {
    _g.bufferData( target, _glView(data), usage ?? WebGL.STATIC_DRAW );
  }

  void bufferDataSize(int target, int size, int? usage) {
    _g.bufferDataSize( target, size, usage ?? WebGL.STATIC_DRAW );
  }

  void clearBufferiv( int buffer, int drawbuffer, int value ) {
    _g.clearBufferiv( buffer, drawbuffer, Int32List.fromList( [value, value, value, value] ).toJS );
  }

  void clearBufferuiv( int buffer, int drawbuffer, int value ) {
    _g.clearBufferuiv( buffer, drawbuffer, Uint32List.fromList( [value, value, value, value] ).toJS );
  }

  void bufferSubData(int target, int dstByteOffset, TypedData data ) {
    _g.bufferSubData( target, dstByteOffset, _glView(data) );
  }

  void vertexAttribPointer(
      int index, int size, int type, bool normalized, int stride, int offset) {
    _g.vertexAttribPointer( index, size, type, normalized, stride, offset);
  }

  void drawArrays(int v0, int v1, int v2) {
    _g.drawArrays(v0, v1, v2);
  }

  void drawArraysInstanced(int v0, int v1, int v2, int v3) {
    _g.drawArraysInstanced( v0, v1, v2, v3 );
  }

  void bindFramebuffer(int target, WxGlFramebuffer? framebuffer) {
    _g.bindFramebuffer( target, framebuffer?._js );
  }

  int checkFramebufferStatus(int target) {
    return _g.checkFramebufferStatus( target );
  }

  void framebufferTexture2D(int target, int attachment, int textarget, WxGlTexture ?texture, int level) {
    _g.framebufferTexture2D( target, attachment, textarget, texture?._js, level );
  }

  void framebufferTextureLayer(int target, int attachment, WxGlTexture? texture, int level, int layer) {
    _g.framebufferTextureLayer( target, attachment, texture?._js, level, layer );
  }

  /// Reads pixels into [pixels], which must match [type] (e.g. a
  /// Uint8List for WebGL.UNSIGNED_BYTE, a Float32List for WebGL.FLOAT)
  void readPixels(int x, int y, int width, int height, int format, int type, TypedData pixels ) {
    final view = _glView( pixels );
    _g.readPixels(x, y, width, height, format, type, view );
    // dart2wasm copies typed data to JS: copy the result back
    if (view == null) return;
    if (pixels is Uint8List) {
      final back = (view as JSUint8Array).toDart;
      if (!identical(back, pixels)) pixels.setAll( 0, back );
    } else if (pixels is Float32List) {
      final back = (view as JSFloat32Array).toDart;
      if (!identical(back, pixels)) pixels.setAll( 0, back );
    } else if (pixels is Uint16List) {
      final back = (view as JSUint16Array).toDart;
      if (!identical(back, pixels)) pixels.setAll( 0, back );
    } else if (pixels is Uint32List) {
      final back = (view as JSUint32Array).toDart;
      if (!identical(back, pixels)) pixels.setAll( 0, back );
    } else if (pixels is Int32List) {
      final back = (view as JSInt32Array).toDart;
      if (!identical(back, pixels)) pixels.setAll( 0, back );
    }
  }

  void copyTexImage2D(int target, int level, int internalformat, int x, int y, int width, int height, int border) {
    _g.copyTexImage2D( target, level, internalformat, x, y, width, height, border );
  }

  void copyTexSubImage2D(int target, int level, int xOffset, int yOffset, int x, int y, int width, int height) {
    _g.copyTexSubImage2D( target, level, xOffset, yOffset, x, y, width, height );
  }

  void copyTexSubImage3D(int target, int level, int xOffset, int yOffset, int zOffset, int x, int y, int width, int height) {
    _g.copyTexSubImage3D( target, level, xOffset, yOffset, zOffset, x, y, width, height );
  }

  void texSubImage2D(int target, int level, int x, int y, int width, int height, int format, int type, TypedData? pixels) {
    _g.texSubImage2D( target, level, x, y, width, height, format, type, _glView(pixels) );
  }

  void texSubImage2D_NOSIZE(int target, int level, int x, int y, int format, int type, TypedData? pixels) {
    wxLogError( "texSubImage2D_NOSIZE not implemented" );
  }

  void texSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, int width, int height, int depth,
      int format, int type, TypedData? pixels) {
    _g.texSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, type, _glView(pixels) );
  }

  void compressedTexSubImage2D(int target, int level, int xoffset, int yoffset, int width, int height,
      int format, TypedData? pixels) {
    _g.compressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, _glView(pixels) );
  }

  void compressedTexSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, 
      int width, int height, int depth, int format, TypedData? pixels) {
    _g.compressedTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, _glView(pixels) );
  }

  void bindRenderbuffer(int target, WxGlRenderbuffer? buffer) {
    _g.bindRenderbuffer( target, buffer?._js );
  }

  void renderbufferStorageMultisample(
      int target, int samples, int internalformat, int width, int height) {
    _g.renderbufferStorageMultisample(target, samples, internalformat, width, height);
  }

  void renderbufferStorage(int v0, int v1, int v2, int v3) {
    _g.renderbufferStorage(v0, v1, v2, v3);
  }

  void framebufferRenderbuffer(int v0, int v1, int v2, WxGlRenderbuffer? buffer) {
    _g.framebufferRenderbuffer( v0, v1, v2, buffer?._js );
  }

  WxGlRenderbuffer createRenderbuffer() {
    return WxGlRenderbuffer._fromJs( _g.createRenderbuffer() );
  }

  WxGlFramebuffer createFramebuffer() {
    return WxGlFramebuffer._fromJs( _g.createFramebuffer() );
  }

  void blitFramebuffer(
      int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1, int mask, int filter) {
    _g.blitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
  }

  WxGlVertexArrayObject createVertexArray() {
    return WxGlVertexArrayObject._fromJs( _g.createVertexArray() );
  }

  WxGlProgram createProgram() {
    return WxGlProgram._fromJs( _g.createProgram() );
  }

  void attachShader(WxGlProgram v0, WxGlShader v1) {
    _g.attachShader( v0._js, v1._js );
  }

  bool isProgram(WxGlProgram v0) {
    return _g.isProgram(v0._js);
  }

  void bindAttribLocation( WxGlProgram program, int index, String name) {
    _g.bindAttribLocation( program._js, index, name );
  }

  void linkProgram(WxGlProgram v0) {
    _g.linkProgram( v0._js );
  }

  String? getProgramInfoLog(WxGlProgram v0) {
    return _g.getProgramInfoLog( v0._js );
  }

  String? getShaderInfoLog(WxGlShader v0) {
    return _g.getShaderInfoLog( v0._js );
  }

  int getError() {
    return _g.getError();
  }

  void deleteShader(WxGlShader v0) {
    _g.deleteShader( v0._js );
  }

  void deleteProgram(WxGlProgram v0) {
    _g.deleteProgram( v0._js );
  }

  void bindVertexArray(WxGlVertexArrayObject v0) {
    _g.bindVertexArray( v0._js );
  }

  void deleteVertexArray(WxGlVertexArrayObject v0) {
    _g.deleteVertexArray( v0._js );
  }

  void enableVertexAttribArray(int v0) {
    _g.enableVertexAttribArray( v0 );
  }

  void disableVertexAttribArray(int v0) {
    _g.disableVertexAttribArray( v0 );
  }

  void vertexAttribIPointer(int v0, int v1, int v2, int v3, int v4) {
    _g.vertexAttribIPointer( v0, v1, v2, v3, v4 );
  }

  void vertexAttrib2fv(int index, Float32List values) {
    _g.vertexAttrib2fv( index, values.toJS );
  }

  void vertexAttrib3fv(int index, Float32List values) {
    _g.vertexAttrib3fv( index, values.toJS );
  }

  void vertexAttrib4fv(int index, Float32List values) {
    _g.vertexAttrib4fv( index, values.toJS );
  }

  void vertexAttrib1fv(int index, Float32List values) {
    _g.vertexAttrib1fv( index, values.toJS );
  }

  void drawElements(int mode, int count, int type, int offset) {
    _g.drawElements( mode, count, type, offset );
  }

  void drawBuffers(Uint32List buffers) {
    _g.drawBuffers( buffers.toJS );
  }

  void drawElementsInstanced(int mode, int count, int type, int offset, int instanceCount) {
    _g.drawElementsInstanced(mode, count, type, offset, instanceCount);
  }

  WxGlShader createShader(int type) {
    return WxGlShader._fromJs( _g.createShader(type) );
  }

  void shaderSource(WxGlShader v0, String shaderSource) {
    _g.shaderSource( v0._js, shaderSource );
  }

  void compileShader(WxGlShader v0) {
    _g.compileShader( v0._js );
  }

  bool getShaderParameter(WxGlShader v0, int v1) {
    final value = _glToDart( _g.getShaderParameter( v0._js, v1 ) );
    if (value is bool) return value;
    if (value is num) return value != 0;
    return false;
  }

  String? getShaderSource(WxGlShader v0) {
    return _g.getShaderSource( v0._js );
  }

  /// Returns the attribute location; its [WxGlUniformLocation.getId]
  /// is the index (or -1 if there is no such attribute)
  WxGlUniformLocation getAttribLocation(WxGlProgram program, String name) {
    return WxGlUniformLocation( _g.getAttribLocation( program._js, name ) );
  }

  // Single int
  void uniform1i(WxGlUniformLocation location, int x) {
    _g.uniform1i( location._js, x );
  }

  // Single floats
  void uniform1f(WxGlUniformLocation location, double x) {
    _g.uniform1f( location._js, x );
  }

  void uniform2f( WxGlUniformLocation location, double x, double y) {
    _g.uniform2f( location._js, x, y);
  }

  void uniform3f(WxGlUniformLocation location, double v1, double v2, double v3) {
    _g.uniform3f( location._js, v1, v2, v3 );
  }

  void uniform4f(WxGlUniformLocation location, double v0, double v1, double v2, double v3) {
    _g.uniform4f( location._js, v0, v1, v2, v3 );
  }

  // Float lists
  void uniform1fv(WxGlUniformLocation location, Float32List values ) {
    _g.uniform1fv( location._js, values.toJS );
  }

  void uniform2fv(WxGlUniformLocation location, Float32List values ) {
    _g.uniform2fv( location._js, values.toJS );
  }

  void uniform3fv(WxGlUniformLocation location, Float32List values) {
    _g.uniform3fv( location._js, values.toJS );
  }

  void uniform4fv(WxGlUniformLocation location, Float32List values) {
    _g.uniform4fv( location._js, values.toJS );
  }

  // Float list transpose
  void uniformMatrix2fv(WxGlUniformLocation location, bool transpose, Float32List values ) {
    _g.uniformMatrix2fv( location._js, transpose, values.toJS );
  }

  void uniformMatrix3fv(WxGlUniformLocation location, bool transpose, Float32List values ) {
    _g.uniformMatrix3fv( location._js, transpose, values.toJS );
  }

  void uniformMatrix4fv(WxGlUniformLocation location, bool transpose, Float32List values ) {
    _g.uniformMatrix4fv( location._js, transpose, values.toJS );
  }

  // Int lists
  void uniform1iv(WxGlUniformLocation location, Int32List values) {
    _g.uniform1iv( location._js, values.toJS );
  }

  void uniform2iv(WxGlUniformLocation location, Int32List values ) {
    _g.uniform2iv( location._js, values.toJS );
  }

  void uniform3iv(WxGlUniformLocation location, Int32List values) {
    _g.uniform3iv( location._js, values.toJS );
  }

  void uniform4iv(WxGlUniformLocation location, Int32List values) {
    _g.uniform4iv( location._js, values.toJS );
  }

  // Single Uint
  void uniform1ui(WxGlUniformLocation location, int value) {
    _g.uniform1ui( location._js, value );
  }

  // Uint lists
  void uniform1uiv(WxGlUniformLocation location, Uint32List values ) {
    _g.uniform1uiv( location._js, values.toJS );
  }

  void uniform2uiv(WxGlUniformLocation location, Uint32List values ) {
    _g.uniform2uiv( location._js, values.toJS );
  }

  void uniform3uiv(WxGlUniformLocation location, Uint32List values) {
    _g.uniform3uiv( location._js, values.toJS );
  }

  void uniform4uiv(WxGlUniformLocation location, Uint32List values) {
    _g.uniform4uiv( location._js, values.toJS );
  }

  void vertexAttribDivisor(int index, int divisor) {
    _g.vertexAttribDivisor( index, divisor );
  }

  void flush() {
    _g.flush();
  }

  void finish() {
    _g.finish();
  }

  void texStorage2D(int target, int levels, int internalformat, int width, int height) {
    _g.texStorage2D(target, levels, internalformat, width, height);
  }

  void texStorage3D(int target, int levels, int internalformat, int width, int height, int depth) {
    _g.texStorage3D(target, levels, internalformat, width, height, depth );
  }

  void bindBufferBase(int target, int index, WxGlBuffer? buffer) {
    _g.bindBufferBase( target, index, buffer?._js );
  }

  WxGlTransformFeedback createTransformFeedback() {
    return WxGlTransformFeedback._fromJs( _g.createTransformFeedback() );
  }

  void bindTransformFeedback(int target, WxGlTransformFeedback transformFeedback) {
    _g.bindTransformFeedback( target, transformFeedback._js );
  }

  void transformFeedbackVaryings(WxGlProgram program, int count, List<String> varyings, int bufferMode) {
    _g.transformFeedbackVaryings( program._js, varyings.take(count).map( (s) => s.toJS ).toList().toJS, bufferMode );
  }

  void deleteTransformFeedback(WxGlTransformFeedback transformFeedback) {
    _g.deleteTransformFeedback(transformFeedback._js);
  }

  bool isTransformFeedback(WxGlTransformFeedback transformFeedback) {
    return _g.isTransformFeedback(transformFeedback._js);
  }

  void beginTransformFeedback(int primitiveMode) {
    _g.beginTransformFeedback(primitiveMode );
  }

  void endTransformFeedback() {
    _g.endTransformFeedback();
  }

  void pauseTransformFeedback() {
    _g.pauseTransformFeedback();
  }

  void resumeTransformFeedback() {
    _g.resumeTransformFeedback();
  }

  WxGlActiveInfo getTransformFeedbackVarying(WxGlProgram program, int index) {
    return _glInfo( _g.getTransformFeedbackVarying( program._js, index ) );
  }

  void invalidateFramebuffer( int target, Uint32List attachments) {
    _g.invalidateFramebuffer( target, attachments.toJS );
  }
}
