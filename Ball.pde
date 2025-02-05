class Ball {
  TriangleMesh mesh;
  Sphere sp;
  Ball() {
    mesh = new TriangleMesh();
  }
  void adapt(int ay, int az) {
    sp = new Sphere(armRay+correction);
    sp.setY(baseLength+armLength+correction);
    mesh = new TriangleMesh();
    mesh.addMesh((TriangleMesh) sp.toMesh(res));
    mesh.rotateZ(radians(az));
    mesh.rotateY(radians(ay));
  }
  void display() {
    gfx.mesh(mesh);
  }
  void rotY(int sens) {
    mesh.rotateY(radians(sens*deg));
  }
  void rotZ(int sens, int angleY) {
    mesh.rotateY(radians(-angleY));
    mesh.rotateZ(radians(sens*deg));
    mesh.rotateY(radians(angleY));
  }
  TriangleMesh getMesh(){
    return mesh;
  }
}
