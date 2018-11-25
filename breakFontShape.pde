import java.awt.Font;
import java.awt.font.FontRenderContext;
import java.awt.image.BufferedImage;
import java.awt.geom.PathIterator;

DamageFontShape damageFontShape;
String fontName = "HiraginoSans-W6";
int fontSize = 50;

void setup() {
  size(600, 400);
  damageFontShape = new DamageFontShape(fontName, fontSize);
}

void draw() {
  background(0);
  ellipse(mouseX, mouseY, 100, 100);
  damageFontShape.createShape("あいうえおaiueo", 100, 100);
}