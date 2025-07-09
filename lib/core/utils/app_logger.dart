import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warn, error, success }

class AppLogger {
  static bool isEnabled = true; // Disable logs in release mode

  static void log(
      String message, {
        String tag = 'APP',
        LogLevel level = LogLevel.debug,
      }) {
    if (!isEnabled) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelLabel = _levelLabel(level);
    final coloredMessage = _colorize("[$timestamp][$tag][$levelLabel] $message", level);

    debugPrint(coloredMessage);
  }

  static String _levelLabel(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return 'DEBUG';
      case LogLevel.info:
        return 'INFO';
      case LogLevel.warn:
        return 'WARN';
      case LogLevel.error:
        return 'ERROR';
      case LogLevel.success:
        return 'SUCCESS';
    }
  }

  static String _colorize(String message, LogLevel level) {
    const reset = '\x1B[0m';
    const red = '\x1B[31m';
    const green = '\x1B[32m';
    const yellow = '\x1B[33m';
    const cyan = '\x1B[36m';
    const white = '\x1B[37m';

    switch (level) {
      case LogLevel.debug:
        return '$cyan$message$reset';
      case LogLevel.info:
        return '$white$message$reset';
      case LogLevel.warn:
        return '$yellow$message$reset';
      case LogLevel.error:
        return '$red$message$reset';
      case LogLevel.success:
        return '$green$message$reset';
    }
  }
}
