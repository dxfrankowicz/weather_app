import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:weather_app/constants/env.dart';
import 'package:weather_app/utils/logconsole/in_memory_logs.dart';

@module
abstract class LoggerDi {
  @lazySingleton
  Logger getLogger(Env env, InMemoryLogs inMemoryLogs) => Logger(
      printer: foundation.kReleaseMode
          ? SimplePrinter(printTime: true)
          : PrettyPrinter(methodCount: 3),
      filter: CrashlyticsFilter(env),
      level: env.data.loggingEnabled ? Level.verbose : Level.nothing,
      output: CrashlyticsOutput(ConsoleOutput(), env, inMemoryLogs.stdLog));
}

class CrashlyticsOutput extends LogOutput {
  LogOutput _delegatedOutput;
  Env _env;
  InMemoryLog _inMemoryLog;

  CrashlyticsOutput(this._delegatedOutput, this._env, this._inMemoryLog);

  @override
  void output(OutputEvent event) {
    if (_env.data.loggingEnabled) {
      _delegatedOutput.output(event);
      _inMemoryLog.add(event);
    }
  }
}

class CrashlyticsFilter extends LogFilter {
  Env _env;

  CrashlyticsFilter(this._env);

  @override
  bool shouldLog(LogEvent event) {
    if (_env.data.loggingEnabled) {
      return true;
    }

    return false;
  }
}
