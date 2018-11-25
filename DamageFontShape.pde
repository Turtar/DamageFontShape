public class DamageFontShape {
  private ArrayList<PathInfo> pathInfoList;

  public DamageFontShape(String _fontName, int _fontSize, String _drawText) {
    pathInfoList = new ArrayList<PathInfo>();
    makePathInfoList(_fontName, _fontSize, _drawText);
    println(pathInfoList.size());
    println(pathInfoList.get(0).pathList.size());

    for (int i=0; i<pathInfoList.size(); i++) {
      println(pathInfoList.get(i).isContour);
    }
  }


  private PathIterator createOutline(String _fontName, int _fontSize, String _drawText) {
    FontRenderContext frc = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB)
      .createGraphics()
      .getFontRenderContext();

    PathIterator iter = new Font(_fontName, Font.PLAIN, _fontSize)
      .createGlyphVector(frc, _drawText)
      .getOutline(0, _fontSize)
      .getPathIterator(null);

    return iter;
  }

  private void makePathInfoList(String _fontName, int _fontSize, String _drawText) {
    String[] drawStrings = _drawText.split("");
    
    
    PathIterator iterator = createOutline(_fontName, _fontSize, _drawText);
    int contours = 0;
    float[] coords = new float[6];
    PathInfo pathInfo = new PathInfo(false);

    while (!iterator.isDone()) {
      int type = iterator.currentSegment(coords);

      if (type == PathIterator.SEG_CLOSE) {
        pathInfoList.add(pathInfo);
        iterator.next();
        continue;
      }

      if (type == PathIterator.SEG_MOVETO) {
        pathInfo = new PathInfo(contours>0);
        contours++;
      }

      pathInfo.addPath(new Path(type, coords));
      iterator.next();
    }
  }


  public void displayShape() {


    for (int i=0; i<pathInfoList.size(); i++) {
      PathInfo pathInfo = pathInfoList.get(i);
      //PathInfo pPathInfo = (i==0) ? null : pathInfoList.get(i-1);

      if (pathInfo.isContour) {
        beginContour();
      } else {
        beginShape();
      }

      for (int j=0; j<pathInfo.getPathList().size(); j++) {
        float[] coords = pathInfo.getPathList().get(j).getCoords();
        vertex(coords[0], coords[1]);
      }

      if (pathInfo.isContour) {
        endContour();
      } else {
        endShape(CLOSE);
      }
    }
  }


  //    while (!iterator.isDone()) {
  //      int type = iterator.currentSegment(coords);
  //      switch (type) {
  //      case PathIterator.SEG_MOVETO: // beginning of new path
  //        if (contours == 0) {
  //          beginShape();
  //        } else {
  //          beginContour();
  //        }
  //        contours++;
  //        vertex(coords[0], coords[1]);
  //        break;

  //      case PathIterator.SEG_LINETO:
  //        vertex(coords[0], coords[1]);
  //        break;

  //      case PathIterator.SEG_CLOSE: // back to last MOVETO point.
  //        if (contours > 1) {
  //          endContour();
  //        }
  //        break;

  //      case PathIterator.SEG_QUADTO:
  //        quadraticVertex(coords[0], coords[1], coords[2], coords[3]);
  //        break;

  //      case PathIterator.SEG_CUBICTO:
  //        bezierVertex(coords[0], coords[1], coords[2], coords[3], coords[4], coords[5]);
  //        break;

  //      default:
  //        throw new RuntimeException("should not reach here");
  //      }
  //      iterator.next();
  //    }
  //    endShape(CLOSE);
}