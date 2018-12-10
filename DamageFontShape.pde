import java.awt.Shape;
public class DamageFontShape {
  private ArrayList<ArrayList<PathInfo>> stringsPathInfoList;
  private int textSumWidth = 0;

  public DamageFontShape(String _fontName, int _fontSize, String _drawText) {
    stringsPathInfoList = new ArrayList<ArrayList<PathInfo>>();
    makePathInfoList(_fontName, _fontSize, _drawText);
  }


  private PathIterator createOutline(String _fontName, int _fontSize, String _drawString, int _index) {
    FontRenderContext frc = new BufferedImage(1, 1, BufferedImage.TYPE_INT_ARGB)
      .createGraphics()
      .getFontRenderContext();

    Shape stringShape = new Font(_fontName, Font.PLAIN, _fontSize)
      .createGlyphVector(frc, _drawString)
      .getOutline(textSumWidth, _fontSize);

    int margin = 5;
    textSumWidth += stringShape.getBounds().width + margin;
    PathIterator iter = stringShape.getPathIterator(null);
    return iter;
  }

  private void makePathInfoList(String _fontName, int _fontSize, String _drawText) {
    String[] drawStrings = _drawText.split("");

    for (int i=0; i<drawStrings.length; i++) {
      PathIterator iterator = createOutline(_fontName, _fontSize, drawStrings[i], i);
      int contours = 0;
      float[] vectorValues = new float[6];

      stringsPathInfoList.add(new ArrayList<PathInfo>());
      PathInfo pathInfo = new PathInfo(false);

      while (!iterator.isDone()) {
        int type = iterator.currentSegment(vectorValues);
        if (type == PathIterator.SEG_CLOSE) {
          stringsPathInfoList.get(i).add(pathInfo);
          iterator.next();
          continue;
        }

        if (type == PathIterator.SEG_MOVETO) {
          pathInfo = new PathInfo(contours > 0);
          contours++;
        }
        pathInfo.addPath(new Path(type, vectorValues));
        iterator.next();
      }
    }
  }


  public void displayShape() {
    for (ArrayList<PathInfo> pathInfoArray : stringsPathInfoList) {
      beginShape();
      for (PathInfo pathInfo : pathInfoArray) {
        if (pathInfo.isContour) {
          beginContour();
        }
        for (int k=0; k<pathInfo.getPathList().size(); k++) {
          float[] vectorValues = pathInfo.getPathList().get(k).getVectorValues();
          switch(pathInfo.getPathList().get(k).pathMode) {
          case PathIterator.SEG_MOVETO:
            vertex(
              vectorValues[0], 
              vectorValues[1]+frameCount/4.0
              );

            break;
          case PathIterator.SEG_LINETO:
            bezierVertex(
              vectorValues[0], 
              vectorValues[1]+frameCount/4.0, 
              vectorValues[0], 
              vectorValues[1], 
              vectorValues[0], 
              vectorValues[1]
              );

            break;
          //case PathIterator.SEG_QUADTO:
          //  quadraticVertex(
          //    vectorValues[0], 
          //    vectorValues[1], 
          //    vectorValues[2], 
          //    vectorValues[3]
          //    );
          //  break;
          case PathIterator.SEG_CUBICTO:
            bezierVertex(
              vectorValues[0], 
              vectorValues[1]+frameCount/4.0, 
              vectorValues[2], 
              vectorValues[3], 
              vectorValues[4], 
              vectorValues[5]
              );
            break;
          }
        }
        if (pathInfo.isContour) {
          endContour();
        }
      }
      endShape(CLOSE);
    }
  }
}