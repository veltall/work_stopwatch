import 'package:flutter/material.dart';
import 'dart:async';
import 'package:date_format/date_format.dart';

/// Stole this file online to implement the routine callbacks
/// that update the timer text.

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class TimerText extends StatefulWidget {
  TimerText({this.stopwatch});
  final Stopwatch stopwatch;

  TimerTextState createState() => new TimerTextState(stopwatch: stopwatch);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.stopwatch});
  final Stopwatch stopwatch;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: 300), callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != stopwatch.elapsedMilliseconds) {
      milliseconds = stopwatch.elapsedMilliseconds;
      // final int hundreds = (milliseconds / 10).truncate();
      // final int seconds = (hundreds / 100).truncate();
      // final int minutes = (seconds / 60).truncate();
      // final ElapsedTime elapsedTime = new ElapsedTime(
      //   hundreds: hundreds,
      //   seconds: seconds,
      //   minutes: minutes,
      // );
      if (stopwatch.isRunning) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle timerTextStyle = TextStyle(
      fontSize: 40.0,
      // fontFamily: "Lato",
      color: stopwatch.isRunning ? Theme.of(context).primaryColor : Colors.grey,
      fontWeight: stopwatch.isRunning ? FontWeight.bold : FontWeight.normal,
      letterSpacing: 2.0,
    );
    String formattedTime =
        TimerTextFormatter.format(stopwatch.elapsedMilliseconds);
    return new Text(formattedTime, style: timerTextStyle);
  }
}

// class MinutesAndSeconds extends StatefulWidget {
//   MinutesAndSeconds({this.dependencies});
//   final Dependencies dependencies;

//   MinutesAndSecondsState createState() => new MinutesAndSecondsState(dependencies: dependencies);
// }

// class MinutesAndSecondsState extends State<MinutesAndSeconds> {
//   MinutesAndSecondsState({this.dependencies});
//   final Dependencies dependencies;

//   int minutes = 0;
//   int seconds = 0;

//   @override
//   void initState() {
//     dependencies.timerListeners.add(onTick);
//     super.initState();
//   }

//   void onTick(ElapsedTime elapsed) {
//     if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
//       setState(() {
//         minutes = elapsed.minutes;
//         seconds = elapsed.seconds;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String minutesStr = (minutes % 60).toString().padLeft(2, '0');
//     String secondsStr = (seconds % 60).toString().padLeft(2, '0');
//     return new Text('$minutesStr:$secondsStr.', style: dependencies.textStyle);
//   }
// }

// class Hundreds extends StatefulWidget {
//   Hundreds({this.dependencies});
//   final Dependencies dependencies;

//   HundredsState createState() => new HundredsState(dependencies: dependencies);
// }

// class HundredsState extends State<Hundreds> {
//   HundredsState({this.dependencies});
//   final Dependencies dependencies;

//   int hundreds = 0;

//   @override
//   void initState() {
//     dependencies.timerListeners.add(onTick);
//     super.initState();
//   }

//   void onTick(ElapsedTime elapsed) {
//     if (elapsed.hundreds != hundreds) {
//       setState(() {
//         hundreds = elapsed.hundreds;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
//     return new Text(hundredsStr, style: dependencies.textStyle);
//   }
// }
class TimerTextFormatter {
  static String format(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    // String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');

    // return "$minutesStr:$secondsStr.$hundredsStr";
    return "$minutesStr:$secondsStr";
  }
}
