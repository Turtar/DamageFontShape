import java.awt.Font;
import java.awt.font.FontRenderContext;
import java.awt.image.BufferedImage;
import java.awt.geom.PathIterator;

DamageFontShape damageFontShape;

void setup() {
  size(600, 400);

  String fontName = "HiraginoSans-W6";
  int fontSize = 50;
  damageFontShape = new DamageFontShape(fontName, fontSize, "あ");
}

void draw() {
  background(0);
  ellipse(mouseX, mouseY, 100, 100);
  damageFontShape.displayShape();
}