import java.awt.Font;
import java.awt.font.FontRenderContext;
import java.awt.image.BufferedImage;
import java.awt.geom.PathIterator;

DamageFontShape damageFontShape;
float rx = 0;
float ry = 0;

void setup() {
  size(1200, 400);

  String fontName = "HiraginoSans-W6";
  int fontSize = 200;
  damageFontShape = new DamageFontShape(fontName, fontSize, "どろどろ");
  blendMode(ADD);
}

void draw() {
  
  background(0);
  noStroke();
  fill(255, 0, 0);
  rx = 10 * cos(frameCount/40.0) * sin(frameCount/4);
  ry = 30 * sin(frameCount/100.0);
  translate(100, 100);
  damageFontShape.displayShape();
}