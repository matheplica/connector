color[] cols = {#0A66F2, #FF0BFF, #F2FD3C, #FF9736, #36E2FF, #FF365E, #A3FF1C, #AC5DED};
void drawInfo() {
  info.beginDraw();
  info.background(0, 0);
  info.fill(0);
  info.textSize(44);
  info.text("Z : "+arms.get(selected).getZ(), 14, 580);
  info.text("Y : "+arms.get(selected).getY(), 17, 615);
  info.text("sel : "+selected, 14, 650);
  info.stroke(84);
  info.pushMatrix();
  info.translate(width>>1, height>>1);
  info.rotateX(mmy);
  info.rotateY(mmx+radians(arms.get(selected).getY()));
  info.rotateZ(radians(arms.get(selected).getZ()));
  info.stroke(32);
  info.shape(arrow, 0, arms.get(selected).getHigh());
  info.popMatrix();
  info.endDraw();
  image(info, 0, 0);
}
