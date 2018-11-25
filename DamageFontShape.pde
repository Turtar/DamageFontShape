public class DamageFontShape {
  ArrayList<PathInfo> pathInformation;
  
  private Font font;
  private PathIterator iterator;

  public DamageFontShape(String fontName, int fontSize) {
    //font = createFont(FontName, fontsize).getFont();
    font = new Font(fontName, Font.PLAIN, fontSize);
  }


  private PathIterator createOutline(String text, float x, float y) {
    FontRenderContext frc = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB)
      .createGraphics()
      .getFontRenderContext();

    PathIterator iter = font.createGlyphVector(frc, text)
      .getOutline(x, y)
      .getPathIterator(null);

    return iter;
  }

  public void createShape(String drawText, float x, float y) {
    iterator = createOutline(drawText, x, y+fontSize);

    int contours = 0;
    float coords[] = new float[6];

    while (!iterator.isDone()) {
      int type = iterator.currentSegment(coords);
      switch (type) {
      case PathIterator.SEG_MOVETO: // beginning of new path
        if (contours == 0) {
          beginShape();
        } else {
          beginContour();
        }
        contours++;
        vertex(coords[0], coords[1]);
        break;

      case PathIterator.SEG_LINETO:
        vertex(coords[0], coords[1]);
        break;

      case PathIterator.SEG_CLOSE: // back to last MOVETO point.
        if (contours > 1) {
          endContour();
        }
        break;

      case PathIterator.SEG_QUADTO:
        quadraticVertex(coords[0], coords[1], coords[2], coords[3]);
        break;

      case PathIterator.SEG_CUBICTO:
        bezierVertex(coords[0], coords[1], coords[2], coords[3], coords[4], coords[5]);
        break;

      default:
        throw new RuntimeException("should not reach here");
      }
      iterator.next();
    }
    endShape(CLOSE);
  }
}