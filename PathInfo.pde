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