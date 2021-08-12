import 'package:flutter/foundation.dart';

import 'log/log.dart';

class Try {
  static toDo(Function fn, {VoidCallback? onException, bool logWarn = true}) {
    try {
      return fn.call();
    } catch (ex) {
      if (logWarn) {
        log.warn("Got exception $ex");
      }
      if (onException != null) {
        onException.call();
      }
    }
  }
}
