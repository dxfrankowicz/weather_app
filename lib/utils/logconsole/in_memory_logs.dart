import 'dart:collection';
import 'package:logger/logger.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class InMemoryLogs {
  final InMemoryLog stdLog = InMemoryLog(bufferSize: 50);
  final InMemoryLog httpLog = InMemoryLog();
}

class InMemoryLog {
  ListQueue<OutputEvent> outputEventBuffer = ListQueue();
  int? bufferSize;

  InMemoryLog({this.bufferSize = 20});

  void add(OutputEvent outputEvent) {
    while (outputEventBuffer.length >= (bufferSize ?? 1)) {
      outputEventBuffer.removeFirst();
    }
    outputEventBuffer.add(outputEvent);
  }
}
