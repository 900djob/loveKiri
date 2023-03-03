abstract class Container {
  String getLog();
}

class UtilFormat {
  static String bzRuntimeType(dynamic obj) {
    return obj.runtimeType.toString() + (obj is Container ? obj.getLog() : (obj is List ? '[${obj.length}]' : ''));
  }
}
