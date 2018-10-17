import 'package:clock/clock.dart';

// Simple wrapper with extra metadata
class Stopwatch {
  DateTime startTime;
  DateTime endTime;
  bool paused;
  bool started;
  Duration netElapsed;
  var clock;

  Stopwatch() {
    this.paused = true;
    this.started = false;
    netElapsed = Duration.zero;
    this.clock = Clock().stopwatch();
  }

  void pause() {
    paused = true;
    this.clock.stop();
    update();
  }

  void stop() {
    this.pause();
  }

  void update() {
    this.netElapsed = this.clock.elapsed;
    this.endTime = DateTime.now();
  }

  void start() {
    paused = false;
    if(!started) {startTime = DateTime.now();}
    this.clock.start();
  }

  void toggle() {
    if (paused) {
      start();
    } else
      pause();
  }

  String elapseString() {
    var val = netElapsed.toString().split('.')[0];
    // print('DEBUG: ' + val);
    return val;
  }
  String timeToString(DateTime dt) {
    String simpleTime = dt.hour.toString() + ":" + dt.minute.toString() + ":" + dt.second.toString();
    return simpleTime;
  }

}

