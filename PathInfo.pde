public class Path {
  public int pathMode;
  private float[] vectorValues;

  public Path(int _pathMode, float[] _vectorValues) {
    pathMode = _pathMode;
    vectorValues = _vectorValues.clone();
  }

  public float[] getVectorValues() {
    return vectorValues;
  }
}

public class Point {
  private float x, y;
  public Point(float _x, float _y) {
    x = _x;
    y = _y;
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }

  public void setX(float _x) {
    x = _x;
  }

  public void setY(float _y) {
    y = _y;
  }
}

public class PathInfo {
  private ArrayList<Path> pathList;
  public boolean isContour;
  private Point centerPoint;

  public PathInfo(boolean _isContour) {
    pathList = new ArrayList<Path>();
    isContour = _isContour;
  }

  public void addPath(Path _path) {
    pathList.add(_path);
  }

  public ArrayList<Path> getPathList() {
    return pathList;
  }

  public void setCenterPoint(float _x, float _y) {
    centerPoint = new Point(_x, _y);
  }

  public Point getCenterPoint() {
    return centerPoint;
  }

  public void setCenterPoint() {
    float sumX = 0;
    float sumY = 0;
    for (Path p : this.pathList) {
      float x = 0;
      float y = 0;
      switch(p.pathMode) {
      case PathIterator.SEG_MOVETO:
        x = p.vectorValues[0];
        y = p.vectorValues[1];
        break;
      case PathIterator.SEG_LINETO:
        x = p.vectorValues[0];
        y = p.vectorValues[1];
        break;
        //case PathIterator.SEG_QUADTO:
        //break;
      case PathIterator.SEG_CUBICTO:
        x = p.vectorValues[4];
        y = p.vectorValues[5];
        break;
      }
      sumX += x;
      sumY += y;
    }
    this.centerPoint = new Point(
      sumX/this.pathList.size(), 
      sumY/this.pathList.size()
      );
  }
}