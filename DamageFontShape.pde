public class DamageFontShape {
  //private ArrayList<PathInfo> pathInfoList;
  private ArrayList<ArrayList<PathInfo>> pathInfoList;

  public DamageFontShape(String _fontName, int _fontSize, String _drawText) {
    pathInfoList = new ArrayList<ArrayList<PathInfo>>();
    makePathInfoList(_fontName, _fontSize, _drawText);
  }


  private PathIterator createOutline(String _fontName, int _fontSize, String _drawString, int _index) {
    FontRenderContext frc = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB)
      .createGraphics()
      .getFontRenderContext();

    PathIterator iter = new Font(_fontName, Font.PLAIN, _fontSize)
      .createGlyphVector(frc, _drawString)
      .getOutline(50*_index, _fontSize)
      .getPathIterator(null);

    return iter;
  }

  private void makePathInfoList(String _fontName, int _fontSize, String _drawText) {
    String[] drawStrings = _drawText.split("");

    for (int i=0; i<drawStrings.length; i++) {
      PathIterator iterator = createOutline(_fontName, _fontSize, drawStrings[i], i);
      int contours = 0;
      float[] coords = new float[6];

      pathInfoList.add(new ArrayList<PathInfo>());
      PathInfo pathInfo = new PathInfo(false);

      while (!iterator.isDone()) {
        int type = iterator.currentSegment(coords);
        if (type == PathIterator.SEG_CLOSE) {
          pathInfoList.get(i).add(pathInfo);
          iterator.next();
          continue;
        }

        if (type == PathIterator.SEG_MOVETO) {
          pathInfo = new PathInfo(contours > 0);
          contours++;
        }
        pathInfo.addPath(new Path(type, coords));
        iterator.next();
      }
    }
  }


  public void displayShape() {
    for (ArrayList<PathInfo> pathInfoArray : pathInfoList) {
      beginShape();
      for (PathInfo pathInfo : pathInfoArray) {
        if (pathInfo.isContour) {
          beginContour();
        }
        for (int k=0; k<pathInfo.getPathList().size(); k++) {
          float[] coords = pathInfo.getPathList().get(k).getCoords();
          vertex(coords[0], coords[1]);
        }
        if (pathInfo.isContour) {
          endContour();
        }
      }
      endShape(CLOSE);
    }
  }
}