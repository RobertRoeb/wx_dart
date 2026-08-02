
import 'package:wx_dart/wx_dart.dart';
import 'dart:typed_data';


class Cube {
  WxGLContext gl;
  late dynamic positionBuffer, normalBuffer, textureCoordBuffer, indexBuffer;

  Float32List? vertices; 
  Float32List? vertexNormals;
  Float32List? textureCoords;
  Uint16List? indxes;

  Cube(this.gl){
    positionBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
    vertices ??= Float32List.fromList([
      // Front face
      -1.0, -1.0, 1.0,
      1.0, -1.0, 1.0,
      1.0, 1.0, 1.0,
      -1.0, 1.0, 1.0,

      // Back face
      -1.0, -1.0, -1.0,
      -1.0, 1.0, -1.0,
      1.0, 1.0, -1.0,
      1.0, -1.0, -1.0,

      // Top face
      -1.0, 1.0, -1.0,
      -1.0, 1.0, 1.0,
      1.0, 1.0, 1.0,
      1.0, 1.0, -1.0,

      // Bottom face
      -1.0, -1.0, -1.0,
      1.0, -1.0, -1.0,
      1.0, -1.0, 1.0,
      -1.0, -1.0, 1.0,

      // Right face
      1.0, -1.0, -1.0,
      1.0, 1.0, -1.0,
      1.0, 1.0, 1.0,
      1.0, -1.0, 1.0,

      // Left face
      -1.0, -1.0, -1.0,
      -1.0, -1.0, 1.0,
      -1.0, 1.0, 1.0,
      -1.0, 1.0, -1.0
    ]);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      vertices!,
      gl.STATIC_DRAW,
    );

    normalBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, normalBuffer);
    vertexNormals ??= Float32List.fromList([
      // Front face
      0.0, 0.0, 1.0,
      0.0, 0.0, 1.0,
      0.0, 0.0, 1.0,
      0.0, 0.0, 1.0,

      // Back face
      0.0, 0.0, -1.0,
      0.0, 0.0, -1.0,
      0.0, 0.0, -1.0,
      0.0, 0.0, -1.0,

      // Top face
      0.0, 1.0, 0.0,
      0.0, 1.0, 0.0,
      0.0, 1.0, 0.0,
      0.0, 1.0, 0.0,

      // Bottom face
      0.0, -1.0, 0.0,
      0.0, -1.0, 0.0,
      0.0, -1.0, 0.0,
      0.0, -1.0, 0.0,

      // Right face
      1.0, 0.0, 0.0,
      1.0, 0.0, 0.0,
      1.0, 0.0, 0.0,
      1.0, 0.0, 0.0,

      // Left face
      -1.0, 0.0, 0.0,
      -1.0, 0.0, 0.0,
      -1.0, 0.0, 0.0,
      -1.0, 0.0, 0.0,
    ]);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      vertexNormals!,
      gl.STATIC_DRAW,
    );

    textureCoordBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, textureCoordBuffer);
    textureCoords = Float32List.fromList([
      // Front face
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,

      // Back face
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      0.0, 0.0,

      // Top face
      0.0, 1.0,
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,

      // Bottom face
      1.0, 1.0,
      0.0, 1.0,
      0.0, 0.0,
      1.0, 0.0,

      // Right face
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
      0.0, 0.0,

      // Left face
      0.0, 0.0,
      1.0, 0.0,
      1.0, 1.0,
      0.0, 1.0,
    ]);
    gl.bufferData(
      gl.ARRAY_BUFFER,
      textureCoords!,
      gl.STATIC_DRAW,
    );
    indxes ??= Uint16List.fromList([
      0, 1, 2, 0, 2, 3, // Front face
      4, 5, 6, 4, 6, 7, // Back face
      8, 9, 10, 8, 10, 11, // Top face
      12, 13, 14, 12, 14, 15, // Bottom face
      16, 17, 18, 16, 18, 19, // Right face
      20, 21, 22, 20, 22, 23 // Left face
    ]);
    indexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
    gl.bufferData(
      gl.ELEMENT_ARRAY_BUFFER,
      indxes!,
      gl.STATIC_DRAW
    );
  }

  void draw({int? vertex, int? normal, int? coord, int? color, void Function()? setUniforms}) {
    if (vertex != null) {
      gl.bindBuffer(gl.ARRAY_BUFFER, positionBuffer);
      gl.vertexAttribPointer(vertex, 3, gl.FLOAT, false, 0, 0);
    }

    if (normal != null) {
      gl.bindBuffer(gl.ARRAY_BUFFER, normalBuffer);
      gl.vertexAttribPointer(normal, 3, gl.FLOAT, false, 0, 0);
    }

    if (coord != null) {
      gl.bindBuffer(gl.ARRAY_BUFFER, textureCoordBuffer);
      gl.vertexAttribPointer(coord, 2, gl.FLOAT, false, 0, 0);
    }

    if (color != null) {
      gl.bindBuffer(gl.ARRAY_BUFFER, this.color.colorBuffer);
      gl.vertexAttribPointer(color, 4, gl.FLOAT, false, 0, 0);
    }

    if (setUniforms != null) setUniforms();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
    gl.drawElements(gl.TRIANGLES, 36, gl.UNSIGNED_SHORT, 0);
  }

  late CubeColor color;
  void addColor(CubeColor color) {
    this.color = color;
  }

  void dispose(){
    // vertices?.dispose();
    // vertexNormals?.dispose();
    // textureCoords?.dispose();
    // indxes?.dispose();

    vertices = null;
    vertexNormals = null;
    textureCoords = null;
    indxes = null;
  }
}

/// Holds a color [Buffer] for our cube's element array
class CubeColor {
  late WxGlBuffer colorBuffer;
  Float32List? unpackedColors; 
  CubeColor(WxGLContext gl) {
    colorBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, colorBuffer);

    /// HARD CODED :'(
    List<List<double>> colors = [
      [1.0, 0.0, 0.0, 1.0], // Front face
      [1.0, 1.0, 0.0, 1.0], // Back face
      [0.0, 1.0, 0.0, 1.0], // Top face
      [1.0, 0.5, 0.5, 1.0], // Bottom face
      [1.0, 0.0, 1.0, 1.0], // Right face
      [0.0, 0.0, 1.0, 1.0] // Left face
    ];
    unpackedColors ??= Float32List(24);
    int k = 0;
    for (var i in colors) {
      for (var j = 0; j < 4; j++) {
        unpackedColors?[k] = i[j];
        k++;
      }
    }
    gl.bufferData(
      gl.ARRAY_BUFFER,
      unpackedColors!,
      gl.STATIC_DRAW,
    );
  }

  void dispose(){
    // unpackedColors?.dispose();
    unpackedColors = null;
  }
}