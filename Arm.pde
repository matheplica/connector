class Arm {
  AxisAlignedCylinder cylBase, cylPot;
  TriangleMesh mesh;
  int id, idCol, angleY, angleZ;
  boolean ball;
  Ball myBall;
  Arm(int id) {
    idCol = id%cols.length;
    myBall = new Ball();
    cylBase = new YAxisCylinder(new Vec3D(0, 0, 0), baseRay, baseLength);
    cylPot = new YAxisCylinder(new Vec3D(0, 0, 0), armRay, armLength);
    adapt();
    if (id>0) rotZ(18);
  }
  void adapt() {
    cylBase.setRadius(baseRay);
    cylBase.setLength(baseLength);
    cylBase.setPosition(new Vec3D(0, baseLength/2, 0));
    cylPot.setRadius(armRay+correction);
    cylPot.setLength(armLength);
    cylPot.setPosition(new Vec3D(0, baseLength+armLength/2, 0));
    mesh = new TriangleMesh();
    mesh.addMesh((TriangleMesh) cylBase.toMesh(res, 0.5));
    mesh.addMesh((TriangleMesh) cylPot.toMesh(res, 0.5));
    mesh.rotateZ(radians(angleZ));
    mesh.rotateY(radians(angleY));
    myBall.adapt(angleY, angleZ);
  }
  void display() {
    noStroke();
    fill(cols[idCol]);
    gfx.mesh(mesh);
  }
  void displayBall() {
    fill(cols[idCol]);
  }
  void rotY(int sens) {
    mesh.rotateY(radians(sens*deg));
    angleY = (360+angleY+sens*deg)%360;
  }
  void rotZ(int sens) {
    mesh.rotateY(radians(-angleY));
    mesh.rotateZ(radians(sens*deg));
    mesh.rotateY(radians(angleY));
    angleZ = (360+angleZ+sens*deg)%360;
  }

  TriangleMesh getMesh() {
    TriangleMesh m = new TriangleMesh();
    m.addMesh(mesh);
    return m;
  }
  void setId(int i) {
    id = i;
  }
  int getY() {
    return angleY;
  }
  int getZ() {
    return angleZ;
  }
  int getHigh() {
    return armLength+baseLength+int(baseRay*((ball) ?  2.1 : 1));
  }
}
