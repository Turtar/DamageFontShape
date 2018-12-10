/*
The MIT License (MIT)

Copyright (c) 2018 Turtar.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

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
  damageFontShape = new DamageFontShape(fontName, fontSize, "熱くなれよ！");
}

void draw() {
  background(0);
  fill(255, 0, 0);
  rx = 10 * cos(frameCount/40.0) * sin(frameCount/4);
  ry = 30 * sin(frameCount/100.0);
  translate(100, 100);
  damageFontShape.displayShape();
}