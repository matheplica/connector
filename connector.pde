//connector 1.0 - matheplica.github.io - last modification : 06/02/2025
import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;
import com.krab.lazy.*;
LazyGui gui;
ToxiclibsSupport gfx;
Sphere ball;
TriangleMesh meshBall;
PGraphics info;
PShape arrow;
float mmx, mmy;
ArrayList<Arm> arms = new ArrayList<Arm>();
boolean centerBall;
int baseLength = 56, baseRay = 32, armLength = 56, armRay = 28;
float correction;
int selected, deg = 5, res = 120;
void setup() {
  size(760, 680, P3D);
  info = createGraphics(width, height, P3D);
  gfx = new ToxiclibsSupport(this);
  gui = new LazyGui(this);
  adaptation();
  arms.add(new Arm(0));
  createArrow(baseLength+armLength);
  hint(ENABLE_KEY_REPEAT);
  arms.get(0).adapt();
}
void draw() {
  baseLength = gui.sliderInt("baseLength", 56, 0, 90);
  baseRay = gui.sliderInt("baseRay", 32, 0, 60);
  armLength = gui.sliderInt("armLength", 56, 0, 90);
  armRay = gui.sliderInt("armRay", 28, 0, 60);
  correction = gui.slider("armAdjust", .8, .0, 1);
  strokeWeight(3);
  background(244);
  ambientLight(237, 220, 220);
  if (mousePressed) {
    if (gui.isMouseOutsideGui()) {
      mmy = mouseY*0.01;
      mmx = mouseX*0.01;
    } else adaptation();
  }
  pushMatrix();
  translate(width>>1, height>>1);
  scale(2, 2);
  rotateX(mmy);
  rotateY(mmx);
  for (Arm r : arms) r.display();
  if (centerBall) {
    fill(27, 255, 32);
    gfx.mesh(meshBall);
  }
  popMatrix();
  drawInfo();
}
void keyPressed() {
  if (keyCode==38 && selected>0) arms.get(selected).rotZ(1);
  else if (keyCode==40 && selected>0) arms.get(selected).rotZ(-1);
  else if (keyCode==37 && selected>0) arms.get(selected).rotY(1);
  else if (keyCode==39 && selected>0) arms.get(selected).rotY(-1);
  else if (key=='d' && selected>0) deleteArm();
  else if (key=='b') centerBall =! centerBall;
  else if (key=='s') saveSTL();
  else if (key=='r') mmx = mmy = 0;
  else if (key=='n') createArm();
  else if (key=='w') selected = (selected<arms.size()-1) ? selected+1 : 0;
  else if (key=='x') selected = (selected>0) ? selected-1 : arms.size()-1;
}
void deleteArm() {
  if (arms.size()>1) {
    arms.remove(selected);
    selected = arms.size()-1;
  }
  for (int i=0; i<arms.size(); i++) arms.get(i).setId(i);
}
void adaptation() {
  for (int i=0; i<arms.size(); i++) arms.get(i).adapt();
  ball = new Sphere(baseRay);
  meshBall = new TriangleMesh();
  meshBall = (TriangleMesh) ball.toMesh(res);
}
void saveSTL() {
  TriangleMesh output = new TriangleMesh("out");
  for (int i=0; i<arms.size(); i++) {
    output.addMesh((TriangleMesh) arms.get(i).getMesh());
  }
  if (centerBall) {
    output.addMesh(meshBall);
  }
  output.scale(0.5);
  output.saveAsSTL(sketchPath("output.stl"));
  println("STL file saved");
}
void createArm() {
  arms.add(new Arm(arms.size()));
  selected = arms.size()-1;
}
void createArrow(int pos) {
  int nPos = (pos/3)*4;
  arrow = createShape();
  arrow.beginShape();
  arrow.strokeWeight(12);
  arrow.vertex(-20, nPos);
  arrow.vertex(0, nPos-40);
  arrow.vertex(20, nPos);
  arrow.noFill();
  arrow.endShape();
}
