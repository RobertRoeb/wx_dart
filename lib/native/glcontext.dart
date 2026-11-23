
part of '../wx_dart.dart';

// ------------------------- wxGLContext ----------------------

typedef _WxGLContextConstructorNative = Pointer Function( Pointer, Pointer  );
typedef _WxGLContextConstructor = Pointer Function( Pointer, Pointer  );
late _WxGLContextConstructor _wxGLContextConstructor;

typedef _WxGLContextIsOKNative = Bool Function( Pointer  );
typedef _WxGLContextIsOK = bool Function( Pointer  );
late _WxGLContextIsOK _wxGLContextIsOK;

typedef _WxGLContextSetCurrentNative = Bool Function( Pointer, Pointer  );
typedef _WxGLContextSetCurrent = bool Function( Pointer, Pointer  );
late _WxGLContextSetCurrent _wxGLContextSetCurrent;

typedef _WxGLContextDoSomethingNative = Int32 Function( Pointer, Int32, Pointer<Utf8>  );
typedef _WxGLContextDoSomething = int Function( Pointer, int, Pointer<Utf8>  );
late _WxGLContextDoSomething _wxGLContextDoSomething;

class WxGlBuffer {
  final int id;
  WxGlBuffer(this.id);
  int getId() { return id; }
}

class WxGlRenderbuffer  {
  final int id;
  WxGlRenderbuffer(this.id);
  int getId() { return id; }
}

class WxGlTexture {
  final int id;
  WxGlTexture(this.id);
  int getId() { return id; }
}

class WxGlVertexArrayObject   {
  final int id;
  WxGlVertexArrayObject(this.id);
  int getId() { return id; }
}

class WxGlProgram  {
  final int id;
  WxGlProgram(this.id);
  int getId() { return id; }
}

class WxGlShader {
  final int id;
  WxGlShader(this.id);
  int getId() { return id; }
}

class WxGlFramebuffer {
  final int id;
  WxGlFramebuffer(this.id);
  int getId() { return id; }
}

class WxGlUniformLocation {
  final int id;
  WxGlUniformLocation(this.id);
  int getId() { return id; }
}

class WxGlTransformFeedback {
  final int id;
  WxGlTransformFeedback(this.id);
  int getId() { return id; }
}

class WxGlActiveInfo {
  String name;
  int size;
  int type;
  WxGlActiveInfo(this.type, this.name, this.size);
  int getType() {
    return type; 
  }
  String getName() {
    return name; 
  }
  int getSize() {
    return size; 
  }
}

class WxGlParameter {
  int id;
  WxGlParameter(this.id);
  int getId() { return id; }
}

class WxGlShaderPrecisionFormat  {
  /// Used internally
  WxGlShaderPrecisionFormat( int precision, int min, int max ) {
    _setPrecision(precision);
    _setRange( min, max );
  }
  late int precision;
  late int rangeMin; 
  late int rangeMax; 

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

abstract class WxGLContext extends WxObject {
  WxGLContext._defaultConstructor() : super._defaultConstructor();
  WxGLContext( WxGLCanvas canvas, WxGLContextAttrs attr ) : super._defaultConstructor()
  {
    _canvas = canvas;
    nativeHandle = _wxGLContextConstructor( canvas.nativeHandle, attr.nativeHandle );
    attachFinalizer();

      // Need to delay onPrepare until window is created or painting
      canvas.bindPaintEvent((event) {
        if (!_hasPrepared) {
          if (_wxGLContextSetCurrent( nativeHandle, canvas.nativeHandle ))
          {
            onPrepare();
            _hasPrepared = true;
            // TODO: clarify why this is needed on Linux and MSW
            final size = canvas.getSize();
            canvas.setSize( WxSize(size.x-1,size.y) );
          }
        }
        event.skip();
      });
  }
  WxGLContext.fromHandle( Pointer handle ) : super._defaultConstructor() {
    nativeHandle = handle;
    attachFinalizer();
  }

  bool _hasPrepared = false;
  void onPrepare();
  late WxGLCanvas _canvas;


  bool isOK( ) {
    return _wxGLContextIsOK( nativeHandle  );
  }

  int getWidth() {
    return _canvas.getSize().x;
  }

  int getHeight() {
    return _canvas.getSize().y;
  }


  bool setCurrent( WxGLCanvas canvas ) {
    final res = _wxGLContextSetCurrent( nativeHandle, canvas.nativeHandle );
    if (res && !_hasPrepared) 
    {
      onPrepare();
      _hasPrepared = true;
    }
    return res;
  }

  int doSomething( int i, String str ) {
    final strUtf8 = str.toNativeUtf8();
    return _wxGLContextDoSomething( nativeHandle, i, strUtf8 );
  }

  void scissor(int x, int y, int z, int w) {
    return glScissor(x, y, z, w);
  }

  void viewport(int x, int y, int width, int height) {
    return glViewport(x, y, width, height);
  }

  WxGlShaderPrecisionFormat getShaderPrecisionFormat(int shaderType, int precisionType) {
    return WxGlShaderPrecisionFormat( 1, 1, 1);
  }

  Object? getExtension(String key) {
    return null;
  }

  List<String> getExtensionDesktop(String key) {
    List<String> extensions = [];
    /*
    var nExtension = glGetIntegerv(GL_NUM_EXTENSIONS);
    for (int i = 0; i < nExtension; i++) {
      extensions.add(_getStringi(GL_EXTENSIONS, i));
    }
    */
    return extensions;
  }

  String _getStringi(int key, int index) {
    Pointer v = glGetStringi(key, index);
    return v.cast<Utf8>().toDartString();
  }

  String getString(int key) {
    Pointer v = glGetString(key);
    return v.cast<Utf8>().toDartString();
  }

  int getParameter(int key)
  {
    // print("OpenGL getParameter key: ${key} ");

    List<int> intValues = [
      GL_MAX_TEXTURE_IMAGE_UNITS,
      GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS,
      GL_MAX_TEXTURE_SIZE,
      GL_MAX_CUBE_MAP_TEXTURE_SIZE,
      GL_MAX_VERTEX_ATTRIBS,
      GL_MAX_VERTEX_UNIFORM_VECTORS,
      GL_MAX_VARYING_VECTORS,
      GL_MAX_FRAGMENT_UNIFORM_VECTORS,
      GL_MAX_SAMPLES,
      GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS,
      GL_SCISSOR_BOX,
      GL_VIEWPORT,
      GL_MAX_UNIFORM_BUFFER_BINDINGS
    ];

    if (intValues.contains(key)) {
      final v = calloc<Int32>(4);
      glGetIntegerv(key, v);
      return v.value;
    } else {
      wxLogError( " OpenGL getParameter key: $key is not support ");
      return 0;
    }
  }

  WxGlTexture createTexture()
  { 
    final vPointer = calloc<Uint32>();
    glGenTextures(1, vPointer);
    int v = vPointer.value;
    calloc.free(vPointer);
    return WxGlTexture( v );
  }

  void bindTexture(int type, WxGlTexture? texture) {
    glBindTexture(type, texture == null ? 0 : texture.getId() );
  }

  void bindTexture2(WxGlTexture texture) {
    return glBindTexture(GL_TEXTURE_2D, texture.getId());
  }

  void activeTexture(int v0) {
    glActiveTexture(v0);
  }

  void texParameteri(int v0, int v1, int v2) {
    glTexParameteri(v0, v1, v2);
  }

  void texImage2D(int target, int level, int internalformat, int width,
      int height, int border, int format, int type, TypedData? pixels)
  {
    if (pixels == null) 
    {
        wxLogError( "No pixel data in glTexImage2D" );
        return;
    } else
    if (pixels is Float32List) 
    {
      if (type != WebGL.FLOAT) {
        wxLogError( "glTexImage2D: pixels is Float32List, but type is not GL_FLOAT" );
        return;
      }
      final Pointer<Float> ptr = calloc<Float>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<double>.from(pixels));
      glTexImage2D( target, level, internalformat, width, height, border, format, type, ptr );
      calloc.free(ptr);
      return;
    } else 
    if (pixels is Uint8List) 
    {
      if (type != WebGL.UNSIGNED_BYTE) {
        wxLogError( "glTexImage2D: pixels is Uint8List, but type is not GL_UNSIGNED_BYTE" );
        return;
      }
      final Pointer<Uint8> ptr = calloc<Uint8>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      glTexImage2D( target, level, internalformat, width, height, border, format, type, ptr );
      calloc.free(ptr);
      return;
    } else 
    if (pixels is Int32List) 
    {
      if (type != WebGL.INT) {
        wxLogError( "glTexImage2D: pixels is Int32List, but type is not GL_INT" );
        return;
      }
      final Pointer<Int32> ptr = calloc<Int32>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      glTexImage2D( target, level, internalformat, width, height, border, format, type, ptr );
      calloc.free(ptr);
      return;
    } 

    wxLogError( "Unsuported data format in glTexImage2D" );        
    /*
    switch (pixels)
    {
        case null:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, nullptr);
        case Float64List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Float32List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Int32List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Int16List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Int8List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Uint32List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Uint16List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Uint8List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Uint64List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
        case Int64List d:
          glTexImage2DLeaf(target, level, internalformat, width, height, border, format, type, d.address.cast<Void>());
      }
      */
  }

  void texImage2D_NOSIZE(
      int target, int level, int internalformat, int format, int type, TypedData? pixels) {
    wxLogError( "texImage2D_NOSIZEnot implemented yet" );
  }

  void texImage3D(int target, int level, int internalformat, int width,
      int height, int depth, int border, int format, int type, TypedData? pixels)
  {
    if (pixels == null) 
    {
        wxLogError( "No pixel data in glTexImage3D" );
        return;
    } else
    if (pixels is Float32List) 
    {
      if (type != WebGL.FLOAT) {
        wxLogError( "glTexImage3D: pixels is Float32List, but type is not GL_FLOAT" );
        return;
      }
      final Pointer<Float> ptr = calloc<Float>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<double>.from(pixels));
      glTexImage3D( target, level, internalformat, width, height, depth, border, format, type, ptr );
      calloc.free(ptr);
      return;
    } else 
    if (pixels is Uint8List) 
    {
      if (type != WebGL.UNSIGNED_BYTE) {
        wxLogError( "glTexImage3D: pixels is Uint8List, but type is not GL_UNSIGNED_BYTE" );
        return;
      }
      final Pointer<Uint8> ptr = calloc<Uint8>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      glTexImage3D( target, level, internalformat, width, height, depth, border, format, type, ptr );
      calloc.free(ptr);
      return;
    } else 
    if (pixels is Int32List) 
    {
      if (type != WebGL.INT) {
        wxLogError( "glTexImage3D: pixels is Int32List, but type is not GL_INT" );
        return;
      }
      final Pointer<Int32> ptr = calloc<Int32>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      glTexImage3D( target, level, internalformat, width, height, depth, border, format, type, ptr );
      calloc.free(ptr);
      return;
    } 

    wxLogError( "Unsuported data format in glTexImage3D" );        
  }

  void depthFunc(int v0) {
    glDepthFunc(v0);
  }

  void depthMask(bool v0) {
    glDepthMask(v0 ? 1 : 0);
  }

  void enable(int v0) {
    glEnable(v0);
  }

  void disable(int v0) {
    glDisable(v0);
  }

  void blendEquation(int v0) {
    glBlendEquation(v0);
  }

  void useProgram(WxGlProgram? program) {
    glUseProgram( program == null ? 0 : program.getId());
  }

  void blendFuncSeparate(int v0, int v1, int v2, int v3) {
    glBlendFuncSeparate(v0, v1, v2, v3);
  }

  void blendFunc(int v0, int v1) {
    glBlendFunc(v0, v1);
  }

  void blendEquationSeparate(int var0, int var1) {
    glBlendEquationSeparate(var0, var1);
  }

  void frontFace(int v0) {
    glFrontFace(v0);
  }

  void cullFace(int v0) {
    glCullFace(v0);
  }

  void lineWidth(double v0) {
    glLineWidth(v0);
  }

  void polygonOffset(double v0, double v1) {
    glPolygonOffset(v0, v1);
  }

  void stencilMask(int v0) {
    glStencilMask( v0 );
  }

  void stencilFunc(int v0, int v1, int v2) {
    glStencilFunc( v0, v1, v2 );
  }

  void stencilOp(int v0, int v1, int v2) {
    glStencilOp( v0, v1, v2 );
  }

  void clearStencil(int v0) {
    glClearStencil(v0);
  }

  void clearDepth(double v0) {
    glClearDepthf(v0);
  }

  void colorMask(bool v0, bool v1, bool v2, bool v3) {
    glColorMask(v0 ? 1 : 0, v1 ? 1 : 0, v2 ? 1 : 0, v3 ? 1 : 0);
  }

  void clearColor(double r, double g, double b, double a) {
    glClearColor(r, g, b, a );
  }

  void generateMipmap(int v0) {
    glGenerateMipmap(v0);
  }

  void deleteTexture(WxGlTexture v0) { 
    final texturesList = [v0.getId()];
    final ptr = calloc<Uint32>(texturesList.length);
    ptr.asTypedList(1).setAll(0, texturesList);
    glDeleteTextures(1, ptr);
    calloc.free(ptr);
  }

  void deleteFramebuffer(WxGlFramebuffer v0) { 
    final list = [v0.getId()];
    final ptr = calloc<Uint32>(list.length);
    ptr.asTypedList(1).setAll(0, list);
    glDeleteFramebuffers(1, ptr);
    calloc.free(ptr);
  }

  void deleteRenderbuffer(WxGlRenderbuffer v0) { 
    final list = [v0.getId()];
    final ptr = calloc<Uint32>(list.length);
    ptr.asTypedList(1).setAll(0, list);
    glDeleteRenderbuffers(1, ptr);
    calloc.free(ptr);
  }

  void texParameterf(int target, int pname, double param) {
    glTexParameterf(target, pname, param);
  }

  void pixelStorei(int v0, int v1) {
    glPixelStorei(v0, v1);
  }

  dynamic getContextAttributes() {
    wxLogError( "getContextAttributes not implemented yet" );        
    return null;
  }

  WxGlParameter getProgramParameter(WxGlProgram program, int pname) {
    final status = calloc<Int32>();
    glGetProgramiv(program.getId(), pname, status);
    final res = status.value;
    calloc.free(status);
    return WxGlParameter( res );
  }

  WxGlActiveInfo getActiveUniform(WxGlProgram program, int v1) {
    final length = calloc<Int32>();
    final size = calloc<Int32>();
    final type = calloc<Uint32>();
    final name = calloc<Int8>(100);

    glGetActiveUniform(program.getId(), v1, 99, length, size, type, name);

    int resType = type.value;
    String resName = name.cast<Utf8>().toDartString();
    int resSize = size.value;
    int resLength = length.value;
    if (resLength > 99) {
      wxLogError( "Buffer overflow in getActiveUniform?" );
    }

    calloc.free(type);
    calloc.free(name);
    calloc.free(size);
    calloc.free(length);

    return WxGlActiveInfo(resType, resName, resSize);
  }

  WxGlActiveInfo getActiveAttrib(WxGlProgram program, int v1) {
    final length = calloc<Int32>();
    final size = calloc<Int32>();
    final type = calloc<Uint32>();
    final name = calloc<Int8>(100);

    glGetActiveAttrib(program.getId(), v1, 99, length, size, type, name);

    int resType = type.value;
    String resName = name.cast<Utf8>().toDartString();
    int resSize = size.value;
    int resLength = length.value;
    if (resLength > 99) {
      wxLogError( "Buffer overflow in getActiveUniform?" );
    }

    calloc.free(type);
    calloc.free(name);
    calloc.free(size);
    calloc.free(length);

    return WxGlActiveInfo(resType, resName, resSize);
  }

  int getUniformBlockIndex( WxGlProgram program, String name ) {
    final nameStr = name.toNativeUtf8();
    final res =  glGetUniformBlockIndex( program.getId(), nameStr );
    calloc.free( nameStr );
    return res;
  }

  void uniformBlockBinding( WxGlProgram program, int uniformBlockIndex, int uniformBlockBinding ) {
    glUniformBlockBinding( program.getId(), uniformBlockIndex, uniformBlockBinding );
  }

  WxGlUniformLocation getUniformLocation(WxGlProgram program, String name) {
    final locationName = name.toNativeUtf8();
    final location = glGetUniformLocation(program.getId(), locationName.cast<Int8>());
    calloc.free(locationName);
    return WxGlUniformLocation( location );
  }

  void clear(int v0) {
    glClear(v0);
  }

  WxGlBuffer createBuffer() {
    Pointer<Uint32> bufferId = calloc<Uint32>();
    glGenBuffers(1, bufferId);
    int res = bufferId.value;
    calloc.free(bufferId);
    return WxGlBuffer( res );
  }

  void deleteBuffer(WxGlBuffer v0) {
    final buffersList = [v0.getId()];
    final ptr = calloc<Uint32>(buffersList.length);
    ptr.asTypedList(1).setAll(0, buffersList);
    glDeleteBuffers(1, ptr);
    calloc.free(ptr);
  }

  void bindBuffer(int v0, WxGlBuffer? buffer) {
    return glBindBuffer(v0, buffer == null ? 0 : buffer.getId());
  }

  Pointer<NativeType> _pixelNativePointer( TypedData? pixels ) {
    if (pixels is Float32List) 
    {
      final Pointer<Float> ptr = calloc<Float>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<double>.from(pixels));
      return ptr;
    } else 
    if (pixels is Int8List) 
    {
      final Pointer<Int8> ptr = calloc<Int8>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      return ptr;
    } else 
    if (pixels is Uint8List) 
    {
      final Pointer<Uint8> ptr = calloc<Uint8>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      return ptr;
    } else 
    if (pixels is Int16List) 
    {
      final Pointer<Int16> ptr = calloc<Int16>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      return ptr;
    } else 
    if (pixels is Uint16List) 
    {
      final Pointer<Uint16> ptr = calloc<Uint16>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      return ptr;
    } else 
    if (pixels is Uint32List) 
    {
      final Pointer<Uint32> ptr = calloc<Uint32>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      return ptr;
    }
    if (pixels is Int32List) 
    {
      final Pointer<Int32> ptr = calloc<Int32>(pixels.length);
      ptr.asTypedList(pixels.length).setAll(0, List<int>.from(pixels));
      return ptr;
    }
    wxLogError( "Unsuported data format" );
    return nullptr;        
  }
 
  void bufferData(int target, TypedData data, int? usage)
  {
    int size = data.lengthInBytes;
    final ptr = _pixelNativePointer( data );
    glBufferData(target, size, ptr, usage ?? 0 );
    calloc.free(ptr);
  }

  void bufferDataSize(int target, int size, int? usage) {
    glBufferData( target, size, nullptr, usage ?? 0 );
  }

  void clearBufferiv( int buffer, int drawbuffer, int value ) {
    final list = [value];
    final ptr = calloc<Int32>(list.length);
    ptr.asTypedList(1).setAll(0, list);
    glClearBufferiv( buffer, drawbuffer, ptr );
    calloc.free(ptr);
  }

  void clearBufferuiv( int buffer, int drawbuffer, int value ) {
    final list = [value];
    final ptr = calloc<Uint32>(list.length);
    ptr.asTypedList(1).setAll(0, list);
    glClearBufferuiv( buffer, drawbuffer, ptr );
    calloc.free(ptr);
  }

  void bufferSubData(int target, int dstByteOffset, TypedData data )
  {
    int size = data.lengthInBytes;

    final ptr = _pixelNativePointer( data );
    glBufferSubData(target, dstByteOffset, size, ptr );
    calloc.free(ptr);
  }

  void vertexAttribPointer(
      int index, int size, int type, bool normalized, int stride, int offset) {
    glVertexAttribPointer( index, size, type, normalized ? 1 : 0, stride, offset);
  }

  void drawArrays(int v0, int v1, int v2) {
    glDrawArrays(v0, v1, v2);
  }

  void drawArraysInstanced(int v0, int v1, int v2, int v3) {
    glDrawArraysInstanced(v0, v1, v2, v3);
  }

  void bindFramebuffer(int target, WxGlFramebuffer? v1) {
    return glBindFramebuffer(target, v1 == null ? 0 : v1.getId());
  }

  int checkFramebufferStatus(int v0) {
    return glCheckFramebufferStatus(v0);
  }

  void framebufferTexture2D(int target, int attachment, int textarget, WxGlTexture ?texture, int level) {
    return glFramebufferTexture2D(target, attachment, textarget, texture == null ? 0 : texture.getId(), level);
  }

  void framebufferTextureLayer(int target, int attachment, WxGlTexture? texture, int level, int layer) {
    glFramebufferTextureLayer( target, attachment, texture == null ? 0 : texture.getId(), level, layer );
  }
  void readPixels(int x, int y, int width, int height, int format, int type, TypedData data)
  {
    if (type == WebGL.UNSIGNED_BYTE) {
      if (data is! Uint8List) {
        wxLogError( "glReadPixels format is GL_UNSIGNED_BYTE, but data format is not Uint8List" );
        return;        
      } else {
        int len = width * height * 4;
        Pointer<Uint8> ptr = malloc.allocate<Uint8>(sizeOf<Uint8>() * len);
        glReadPixels(x, y, width, height, format, type, ptr);

        // TODO: find a more elegant way
        final pixelbuffer  = ptr.asTypedList(len);
        for (int i = 0; i < pixelbuffer.length; i++ ) {
          data[i] = pixelbuffer[i];
        }

        data = pixelbuffer;

        calloc.free(ptr);
        return;
      }
    } else
    if (type == WebGL.INT) {
      if (data is! Int32List) {
        wxLogError( "glReadPixels format is GL_INT, but data format is not Int32List" );
        return;        
      } else {
        int len = width * height * 4;
        Pointer<Int32> ptr = malloc.allocate<Int32>(sizeOf<Int32>() * len);
        glReadPixels(x, y, width, height, format, type, ptr);

        // TODO: find a more elegant way
        final pixelbuffer  = ptr.asTypedList(len);
        for (int i = 0; i < pixelbuffer.length; i++ ) {
          data[i] = pixelbuffer[i];
        }

        data = pixelbuffer;

        calloc.free(ptr);
        return;
      }
    } else
    if (type == WebGL.FLOAT) {
      if (data is! Float32List) {
        wxLogError( "glReadPixels format is GL_FLOAT, but data format is not Float32List" );
        return;        
      } else {
        int len = width * height * 4;
        Pointer<Float> ptr = malloc.allocate<Float>(sizeOf<Float>() * len);
        glReadPixels(x, y, width, height, format, type, ptr);

        // TODO: find a more elegant way
        final pixelbuffer  = ptr.asTypedList(len);
        for (int i = 0; i < pixelbuffer.length; i++ ) {
          data[i] = pixelbuffer[i];
        }

        data = pixelbuffer;

        calloc.free(ptr);
        return;
      }
    }

    wxLogError( "Unsupported type in readPixels" );        
  }

  void copyTexImage2D(int target, int level, int internalformat, int x, int y, int width, int height, int border) {
    glCopyTexImage2D( target, level, internalformat, x, y, width, height, border );
  }

  void copyTexSubImage2D(int target, int level, int xOffset, int yOffset, int x, int y, int width, int height) {
    glCopyTexSubImage2D( target, level, xOffset, yOffset, x, y, width, height );
  }

  void copyTexSubImage3D(int target, int level, int xOffset, int yOffset, int zOffset, int x, int y, int width, int height) {
    glCopyTexSubImage3D( target, level, xOffset, yOffset, zOffset, x, y, width, height );
  }
  void texSubImage2D_NOSIZE(int target, int level, int x, int y, int format, int type, TypedData? pixels) {
    wxLogError( "texSubImage2D_NOSIZE not implemented" );
  }

  void texSubImage2D(int target, int level, int x, int y, int width, int height, int format, int type, TypedData? pixels)
  {
    if (pixels != null) {
      final ptr = _pixelNativePointer( pixels );
      glTexSubImage2D( target, level, x, y, width, height, format, type, ptr );
      calloc.free(ptr);
      return;
    }
  }

 void texSubImage3D(int target, int level, int x, int y, int z, int width, int height, int depth,
      int format, int type, TypedData? pixels)
  {
    if (pixels != null) {
      final ptr = _pixelNativePointer( pixels );
      glTexSubImage3D( target, level, x, y, z, width, height, depth, format, type, ptr );
      calloc.free(ptr);
      return;
    }
  }

  void compressedTexImage2D(int target, int level, int internalformat,
      int width, int height, int border, TypedData? pixels)
  {
    if (pixels != null) {
      final ptr = _pixelNativePointer( pixels );
      glCompressedTexImage2D( target, level, internalformat, width, height, border, pixels.lengthInBytes, ptr );
      calloc.free(ptr);
      return;
    }
  }

  void compressedTexImage3D(int target, int level, int internalformat,
      int width, int height, int depth, int border, TypedData? pixels) {
    if (pixels != null) {
      final ptr = _pixelNativePointer( pixels );
      glCompressedTexImage3D( target, level, internalformat, width, height, depth, border, pixels.lengthInBytes, ptr );
      calloc.free(ptr);
    }
  }

  void compressedTexSubImage2D(int target, int level, int x, int y, int width, int height,
      int format, TypedData? pixels)
  {
    if (pixels != null) {
      final ptr = _pixelNativePointer( pixels );
      glCompressedTexSubImage2D( target, level, x, y, width, height, format, pixels.lengthInBytes, ptr );
      calloc.free(ptr);
      return;
    }
  }
  void compressedTexSubImage3D(int target, int level, int xoffset, int yoffset, int zoffset, 
      int width, int height, int depth, int format, TypedData? pixels) {
    if (pixels != null) {
      final ptr = _pixelNativePointer( pixels );
      glCompressedTexSubImage3D(target, level, xoffset, yoffset, zoffset, width, height, depth, format, pixels.lengthInBytes, ptr );
      calloc.free(ptr);
      return;
    }
  }

  void bindRenderbuffer(int target, WxGlRenderbuffer? buffer) {
    return glBindRenderbuffer(target, buffer == null ? 0 : buffer.getId());
  }

  void renderbufferStorageMultisample(
      int target, int samples, int internalformat, int width, int height) {
    return glRenderbufferStorageMultisample(
        target, samples, internalformat, width, height);
  }

  void renderbufferStorage(int v0, int v1, int v2, int v3) {
    glRenderbufferStorage(v0, v1, v2, v3);
  }

  void framebufferRenderbuffer(int v0, int v1, int v2, WxGlRenderbuffer? buffer) {
    glFramebufferRenderbuffer(v0, v1, v2, buffer == null ? 0 : buffer.getId());
  }

  WxGlRenderbuffer createRenderbuffer() {
    final v = calloc<Uint32>();
    glGenRenderbuffers(1, v);
    int res = v.value;
    calloc.free(v);
    return WxGlRenderbuffer(res);
  }

  WxGlFramebuffer createFramebuffer() {
    final v = calloc<Uint32>();
    glGenFramebuffers(1, v);
    int res = v.value;
    calloc.free(v);
    return WxGlFramebuffer(res);
  }

  void genFramebuffers(int v0, Pointer<Uint32> v1) {
    glGenFramebuffers(v0, v1);
  }

  void blitFramebuffer(
      int srcX0, int srcY0, int srcX1, int srcY1, int dstX0, int dstY0, int dstX1, int dstY1, int mask, int filter)
  {
    return glBlitFramebuffer(
        srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter);
  }

  WxGlVertexArrayObject createVertexArray()
  {
    final v = calloc<Uint32>();
    glGenVertexArrays(1, v);
    int res = v.value;
    calloc.free(v);
    return WxGlVertexArrayObject(res);
  }

  WxGlProgram createProgram() {
    return WxGlProgram( glCreateProgram() );
  }

  void attachShader(WxGlProgram v0, WxGlShader v1) {
    return glAttachShader(v0.getId(), v1.getId());
  }

  bool isProgram(WxGlProgram v0) {
    return glIsProgram(v0.getId()) == 1;
  }

  void bindAttribLocation( WxGlProgram program, int index, String name)
  {
    final n = name.toNativeUtf8();
    glBindAttribLocation(program.getId(), index, n.cast<Int8>());
    calloc.free(n);
  }

  void linkProgram(WxGlProgram v0) {
    glLinkProgram(v0.getId());
  }

  String? getProgramInfoLog(WxGlProgram v0) {
    var infoLen = calloc<Int32>();

    glGetProgramiv(v0.getId(), GL_INFO_LOG_LENGTH, infoLen);

    int len = infoLen.value;
    calloc.free(infoLen);

    String message = '';

    if (infoLen.value > 0) {
      final infoLog = calloc<Int8>(len);
      glGetProgramInfoLog(v0.getId(), len, nullptr, infoLog);

      message =
          "\nError compiling shader:\n${infoLog.cast<Utf8>().toDartString()}";
      calloc.free(infoLog);
      return message;
    } else {
      return null;
    }
  }

  String? getShaderInfoLog(WxGlShader v0)
  {
    final infoLen = calloc<Int32>();
    glGetShaderiv(v0.getId(), GL_INFO_LOG_LENGTH, infoLen);

    int _len = infoLen.value;
    calloc.free(infoLen);

    String message = '';
    if (infoLen.value > 1) {
      final infoLog = calloc<Int8>(_len);

      glGetShaderInfoLog(v0.getId(), _len, nullptr, infoLog);
      message =
          "\nError compiling shader:\n${infoLog.cast<Utf8>().toDartString()}";

      calloc.free(infoLog);
      return message;
    }
    return null;
  }

  int getError() {
    return glGetError();
  }

  void deleteShader(WxGlShader v0) {
    glDeleteShader(v0.getId());
  }

  void deleteProgram(WxGlProgram v0) {
    glDeleteProgram(v0.getId());
  }

  void bindVertexArray(WxGlVertexArrayObject v0) {
    glBindVertexArray(v0.getId());
  }

  void deleteVertexArray(WxGlVertexArrayObject v0) {
    final list = [v0.getId()];
    final ptr = calloc<Uint32>(list.length);
    ptr.asTypedList(1).setAll(0, list);
    glDeleteVertexArrays(1, ptr);
    calloc.free(ptr);
  }

  void enableVertexAttribArray(int v0) {
    glEnableVertexAttribArray(v0);
  }

  void disableVertexAttribArray(int v0) {
    glDisableVertexAttribArray(v0);
  }

  void vertexAttribIPointer(int v0, int v1, int v2, int v3, int v4) {
    glVertexAttribIPointer(v0, v1, v2, v3, v4);
  }

  void vertexAttrib1fv(int index, Float32List values) {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glVertexAttrib1fv(index, ptr);
    calloc.free( ptr );
  }

  void vertexAttrib2fv(int index, Float32List values) {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glVertexAttrib2fv(index, ptr);
    calloc.free( ptr );
  }

  void vertexAttrib3fv(int index, Float32List values) {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glVertexAttrib3fv(index, ptr);
    calloc.free( ptr );
  }

  void vertexAttrib4fv(int index, Float32List values) {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glVertexAttrib4fv(index, ptr);
    calloc.free( ptr );
  }

  void drawElements(int mode, int count, int type, int offset) {
    final offSetPointer = Pointer<Void>.fromAddress(offset);
    glDrawElements(mode, count, type, offSetPointer.cast<Void>());
    calloc.free(offSetPointer);
    return;
  }

  void drawBuffers(Uint32List buffers)
  {
    // TODO: use leaf
    final ptr = calloc<Uint32>(buffers.length);
    ptr.asTypedList(buffers.length).setAll(0, List<int>.from(buffers));

    glDrawBuffers(buffers.length, ptr);

    calloc.free(ptr);
    return;
  }

  void drawElementsInstanced(int mode, int count, int type, int offset, int instanceCount) {
    final offSetPointer = Pointer<Void>.fromAddress(offset);
    glDrawElementsInstanced(mode, count, type, offSetPointer, instanceCount);
    calloc.free(offSetPointer);
    return;
  }

  WxGlShader createShader(int type) {
    return WxGlShader( glCreateShader(type) );
  }

  void shaderSource(WxGlShader v0, String shaderSource)
  {
    var sourceString = shaderSource.toNativeUtf8();
    var arrayPointer = calloc<Pointer<Int8>>();
    arrayPointer.value = Pointer.fromAddress(sourceString.address);
    glShaderSource(v0.getId(), 1, arrayPointer, nullptr);
    calloc.free(arrayPointer);
    calloc.free(sourceString);
  }

  void compileShader(WxGlShader v0)
  {
    return glCompileShader(v0.getId());
  }

  bool getShaderParameter(WxGlShader v0, int v1)
  {
    final pointer = calloc<Int32>();
    glGetShaderiv(v0.getId(), v1, pointer);

    final res = pointer.value;
    calloc.free(pointer);

    return res == 1;
  }

  String? getShaderSource(int v0)
  {
    return null;
    // TODO
    // return glGetShaderSource(v0);  
  }

 WxGlUniformLocation getAttribLocation(WxGlProgram program, String name)
 {
    final locationName = name.toNativeUtf8();
    final location = glGetAttribLocation(program.getId(), locationName);
    calloc.free(locationName);
    return WxGlUniformLocation( location );
  }

  // Single int

  void uniform1i(WxGlUniformLocation location, int v1) {
    glUniform1i(location.getId(), v1);
  }

  // Single floats

  void uniform1f(WxGlUniformLocation location, double x) {
    glUniform1f(location.getId(), x );
  }

  void uniform2f( WxGlUniformLocation location, double x, double y) {
    glUniform2f(location.getId(), x, y );
  }

  void uniform3f(WxGlUniformLocation location, double v1, double v2, double v3) {
    return glUniform3f(location.getId(), v1, v2, v3);
  }

  void uniform4f(WxGlUniformLocation location, double v0, double v1, double v2, double v3) {
    glUniform4f(location.getId(), v0, v1, v2, v3 );
  }

  // Float lists

  void uniform1fv(WxGlUniformLocation location, Float32List values )
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniform1fv( location.getId(), values.length ~/ 1, ptr );
    calloc.free(ptr);
  }

  void uniform2fv(WxGlUniformLocation location, Float32List values )
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniform2fv( location.getId(), values.length ~/ 2, ptr );
    calloc.free(ptr);
  }

  void uniform3fv(WxGlUniformLocation location, Float32List values)
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniform3fv( location.getId(), values.length ~/ 3, ptr );
    calloc.free(ptr);
  }

  void uniform4fv(WxGlUniformLocation location, Float32List values)
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniform4fv( location.getId(), values.length ~/ 4, ptr );
    calloc.free(ptr);
  }

  // Float list transpose

  void uniformMatrix2fv(WxGlUniformLocation location, bool transpose, Float32List values )
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniformMatrix2fv( location.getId(), values.length ~/ 4, transpose ? 1 : 0, ptr );
    calloc.free(ptr);
  }

  void uniformMatrix3fv(WxGlUniformLocation location, bool transpose, Float32List values )
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniformMatrix3fv( location.getId(), values.length ~/ 9, transpose ? 1 : 0, ptr );
    calloc.free(ptr);
  }

  void uniformMatrix4fv(WxGlUniformLocation location, bool transpose, Float32List values )
  {
    final Pointer<Float> ptr = calloc<Float>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<double>.from(values));
    glUniformMatrix4fv( location.getId(), values.length ~/ 16, transpose ? 1 : 0, ptr );
    calloc.free(ptr);
  }

  // Int lists

//    final Pointer<Uint32> ptr = calloc<Uint32>(data.length);
//    ptr.asTypedList(data.length).setAll(0, data.map((e) => e));
  void uniform1iv(WxGlUniformLocation location, Int32List values)
  {
    final Pointer<Int32> ptr = calloc<Int32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform1iv( location.getId(), values.length ~/ 1, ptr );
    calloc.free(ptr);
  }

  void uniform2iv(WxGlUniformLocation location, Int32List values )
  {
    final Pointer<Int32> ptr = calloc<Int32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform2iv( location.getId(), values.length ~/ 2, ptr );
    calloc.free(ptr);
  }

  void uniform3iv(WxGlUniformLocation location, Int32List values)
  {
    final Pointer<Int32> ptr = calloc<Int32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform3iv( location.getId(), values.length ~/ 3, ptr );
    calloc.free(ptr);
  }

  void uniform4iv(WxGlUniformLocation location, Int32List values)
  {
    final Pointer<Int32> ptr = calloc<Int32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform4iv( location.getId(), values.length ~/ 4, ptr );
    calloc.free(ptr);
  }

  // Single Uint

  void uniform1ui(WxGlUniformLocation location, int value) {
    glUniform1ui( location.getId(), value );
  }

  // Uint lists

  void uniform1uiv(WxGlUniformLocation location, Uint32List values ) {
    final Pointer<Uint32> ptr = calloc<Uint32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform1uiv( location.getId(), values.length ~/ 1, ptr );
    calloc.free(ptr);
  }

  void uniform2uiv(WxGlUniformLocation location, Uint32List values ) {
    final Pointer<Uint32> ptr = calloc<Uint32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform2uiv( location.getId(), values.length ~/ 2, ptr );
    calloc.free(ptr);
  }

  void uniform3uiv(WxGlUniformLocation location, Uint32List values) {
    final Pointer<Uint32> ptr = calloc<Uint32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform3uiv( location.getId(), values.length ~/ 3, ptr );
    calloc.free(ptr);
  }

  void uniform4uiv(WxGlUniformLocation location, Uint32List values) {
    final Pointer<Uint32> ptr = calloc<Uint32>(values.length);
    ptr.asTypedList(values.length).setAll(0, List<int>.from(values));
    glUniform4uiv( location.getId(), values.length ~/ 4, ptr );
    calloc.free(ptr);
  }


  void vertexAttribDivisor(int index, int divisor) {
    glVertexAttribDivisor(index, divisor);
  }

  void flush() {
    glFlush();
  }

  void finish() {
    glFinish();
  }

  void texStorage2D(int target, int levels, int internalformat, int width, int height) {
    glTexStorage2D(target, levels, internalformat, width, height);
  }

  void texStorage3D(int target, int levels, int internalformat, int width, int height, int depth) {
    glTexStorage3D(target, levels, internalformat, width, height, depth);
  }
  
  void bindBufferBase(int target, int index, WxGlBuffer? buffer) {
    glBindBufferBase(target, index, buffer == null ? 0 : buffer.getId() );
  }

  WxGlTransformFeedback createTransformFeedback()
  {
    final vPointer = calloc<Uint32>();
    glGenTransformFeedbacks(1, vPointer);
    int res = vPointer.value;
    calloc.free(vPointer);
    return WxGlTransformFeedback( res );
  }

  void bindTransformFeedback(int target, WxGlTransformFeedback transformFeedback) {
    return glBindTransformFeedback(target, transformFeedback.getId() );
  }

  void transformFeedbackVaryings(WxGlProgram program, int count, List<String> varyings, int bufferMode)
  {
    final varyingsPtr = calloc<Pointer<Int8>>(varyings.length);

    int i = 0;
    for(final varying in varyings) {
      varyingsPtr[i] = varying.toNativeUtf8().cast<Int8>();
      i = i + 1;
    }

    glTransformFeedbackVaryings(program.getId(), count, varyingsPtr, bufferMode);
    calloc.free(varyingsPtr);

    return;
  }

  void deleteTransformFeedback(WxGlTransformFeedback transformFeedback)
  {
    final list = [transformFeedback.getId()];
    final ptr = calloc<Uint32>(list.length);
    ptr.asTypedList(1).setAll(0, list);
    glDeleteTransformFeedbacks(1, ptr);
    calloc.free(ptr);
  }

  bool isTransformFeedback(WxGlTransformFeedback transformFeedback) {
    return glIsTransformFeedback(transformFeedback.getId()) == 1;
  }
  void beginTransformFeedback(int primitiveMode) {
    glBeginTransformFeedback(primitiveMode);
  }
  void endTransformFeedback() {
    glEndTransformFeedback();
  }
  void pauseTransformFeedback() {
    glPauseTransformFeedback();
  }
  void resumeTransformFeedback() {
    glResumeTransformFeedback();
  }

  WxGlActiveInfo getTransformFeedbackVarying(WxGlProgram program, int index)
  {
    int maxLen = 100;
    final length = calloc<Int32>();
    final size = calloc<Int32>();
    final type = calloc<Uint32>();
    final name = calloc<Int8>(maxLen);

    glGetTransformFeedbackVarying(program.getId(), index, maxLen - 1, length, size, type, name);

    int resType = type.value;
    String resName = name.cast<Utf8>().toDartString();
    int resSize = size.value;
    int resLength = length.value;
    if (resLength > 99) {
      wxLogError( "Buffer overflow in getActiveUniform?" );
    }

    calloc.free(type);
    calloc.free(name);
    calloc.free(size);
    calloc.free(length);

    return WxGlActiveInfo(resType, resName, resSize);
  }

  void invalidateFramebuffer( int target, Uint32List attachments)
  {
    // TODO 
//     return glInvalidateFramebuffer(target, attachments.length, attachments);
    return glInvalidateFramebuffer(target, 0, nullptr );
  }

  int getIntegerv(int v0) {
    Pointer<Int32> ptr = calloc<Int32>();
    glGetIntegerv(v0, ptr);

    int _v = ptr.value;
    calloc.free(ptr);

    return _v;
  }


}

void setupWxGlContext( DynamicLibrary dylib )
{
  // ------------------------- wxGLContext ----------------------

  final wxGLContextConstructorPtr = dylib.lookup <NativeFunction<_WxGLContextConstructorNative>>('wxGLContextConstructor');
  _wxGLContextConstructor = wxGLContextConstructorPtr.asFunction<_WxGLContextConstructor>();

  final wxGLContextIsOKPtr = dylib.lookup <NativeFunction<_WxGLContextIsOKNative>>('wxGLContextIsOK');
  _wxGLContextIsOK = wxGLContextIsOKPtr.asFunction<_WxGLContextIsOK>();

  final wxGLContextSetCurrentPtr = dylib.lookup <NativeFunction<_WxGLContextSetCurrentNative>>('wxGLContextSetCurrent');
  _wxGLContextSetCurrent = wxGLContextSetCurrentPtr.asFunction<_WxGLContextSetCurrent>();

  final wxGLContextDoSomethingPtr = dylib.lookup <NativeFunction<_WxGLContextDoSomethingNative>>('wxGLContextDoSomething');
  _wxGLContextDoSomething = wxGLContextDoSomethingPtr.asFunction<_WxGLContextDoSomething>();
}