public class Path {
  public int pathMode;
  private float[] coords;
  
  public Path(int _pathMode, float[] _coords) {
    pathMode = _pathMode;
    coords = _coords.clone();
  }
  
  public float[] getCoords() {
    return coords;
  }
}


public class PathInfo {
  private ArrayList<Path> pathList;
  public boolean isContour;
  
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
}