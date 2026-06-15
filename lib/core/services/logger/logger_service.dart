import "dart:developer";

import "package:hive_ce/hive.dart";
import "package:logger/logger.dart";

export "package:logger/logger.dart";

/// Returns a logger instance with the given [className]
///
/// Use this function to get a logger instance with the class name
/// to easily identify the logs.
///
/// Adapted to handle global hive logging
Logger getLogger(String className) {
  // Configure the overall logging level
  HiveLogger.level = HiveLoggerLevel.error;

  // Disable the unsafe isolate warning
  HiveLogger.unsafeIsolateWarning = false;

  return Logger(
    printer: _LoggerService(className),
    output: _DeveloperConsoleOutput(),
  );
}

class _LoggerService extends LogPrinter {
  _LoggerService(this.className);

  final String className;

  @override
  List<String> log(LogEvent event) {
    final AnsiColor? color = PrettyPrinter.defaultLevelColors[event.level];
    final String? emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    final message = event.message;

    return [color!("$emoji $className - $message")];
  }
}

class _DeveloperConsoleOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    final StringBuffer buffer = StringBuffer();
    event.lines.forEach(buffer.writeln);
    log(buffer.toString());
  }
}
