import 'dart:isolate';

void countdownIsolate(SendPort sendPort) {
  final now = DateTime.now();
  while (true) {
    sendPort.send("Updated Time: ${now.toString()}");
    Future.delayed(const Duration(seconds: 1));
  }
}