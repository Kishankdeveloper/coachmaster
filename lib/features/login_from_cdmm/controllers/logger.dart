import 'package:logger/logger.dart';

/*
You can log with different levels:
logger.v("Verbose log");
logger.d("Debug log");
logger.i("Info log");
logger.w("Warning log");
logger.e("Error log");
logger.wtf("What a terrible failure log");
To show only specific log levels, you can set:
Logger.level = Level.warning;
This hides all verbose, debug and info log events.
*/

Logger getLogger(String className) {
  return Logger(printer: _SimpleLogPrinter(className));
}

class _SimpleLogPrinter extends PrettyPrinter {
  final String className;
  _SimpleLogPrinter(this.className);
}
