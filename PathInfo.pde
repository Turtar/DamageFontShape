// PathInfo
//   ArrayList<Path>
//     pathMode: int (ex PathIterator.SEG_MOVETO)
//     coords: float[6]
//   isContour: boolean


public class Path {
  int pathMode;
  float[] coords;
  
  public Path(int _pathMode, float[] _coords) {
    pathMode = _pathMode;
    coords = _coords.clone();
  }
}


public class PathInfo {
  ArrayList<Path> paths;
  boolean isContour;
  
  public PathInfo(boolean _isContour) {
    paths = new ArrayList<Path>();
    isContour = _isContour;
  }
  
  public void addInfo(Path _path) {
    paths.add(_path);
  }
}