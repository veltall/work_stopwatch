import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'stopwatch.dart';

enum task_type {
  preparation,
  checking,
  spotting,
  throwing,
  cleaning,
  resting,
  facing
}
enum performance { ahead, behind, ontime, unknown }

class Task {
  String id;
  int loadSize;
  task_type type;
  DateTime startTime; // documentary purposes
  DateTime finishTime;
  Duration adjustedTimeAllocation; // projected based on work load
  Duration actualTime; // measured with stopwatch
  Duration dT;
  performance result;
  bool started;
  bool finished;
  Stopwatch watch;

  // example initiation: new Task(id: "T-13C", loadSize: 78)
  Task({@required String id, int loadSize}) {
    startTime = null;
    finishTime = null;
    actualTime = null;
    result = performance.unknown;
    started = false;
    finished = false;
    watch = new Stopwatch();

    this.id = id;
    this.loadSize =
        loadSize == null ? GOAL_TIMES[id] : loadSize; // default to goal times
    this.adjustedTimeAllocation = new Duration(minutes: this.loadSize);
    var tasktype = id.split('-')[0];
    switch (tasktype) {
      case 'Preparation':
        this.type = task_type.preparation;
        break;
      case 'Checking':
        this.type = task_type.checking;
        break;
      case 'S':
        this.type = task_type.spotting;
        break;
      case 'T':
        this.type = task_type.throwing;
        break;
      case 'C':
        this.type = task_type.cleaning;
        break;
      case 'R':
        this.type = task_type.resting;
        break;
      case 'F':
        this.type = task_type.facing;
        break;
      default:
        this.type = task_type.resting;
        break;
    }
  }

  void updateLoadSize(int newSize) {
    this.loadSize = newSize;
    this.adjustedTimeAllocation = new Duration(minutes: loadSize);
  }

  void start() {
    if (!started) {
      startTime = new DateTime.now();
      started = true;
    }
    watch.start(); // resume if already started
  }

  bool isActive() => this.watch.isRunning;

  void pause() {
    watch.stop();
    update();
  }

  void end() {
    pause();
    update();
  }

  void toggle() {
    if (isActive())
      pause();
    else
      start();
  }

  void update() {
    this.finished = true;
    this.finishTime = DateTime.now();
    this.actualTime = watch.elapsed;
    this.dT = actualTime - adjustedTimeAllocation;
    switch (this.dT.isNegative) {
      case true:
        result = performance.ahead;
        break;
      case false:
        result = performance.behind;
        break;
      default:
        result = performance.ontime;
        break;
    }
  }

  // in minutes
  static const Map<String, int> GOAL_TIMES = {
    'Preparation-': 20,
    'Checking-': 30,
    'S-13-C': 20,
    'S-13-P': 10, // breaking, aisle 13, pet side
    'T-13-C': 50,
    'T-13-P': 20,
    'C-13': 15,
    'T-6': 30,
    'C-6': 10,
    'T-5': 5,
    'T-4': 20,
    'C-4': 5,
    'T-12': 20,
    'Rest-': 30,
    'F-13': 40,
    'F-12': 10,
    'F-10': 20,
    'F-9': 45,
    'F-8': 45,
    'F-7': 45,
    'F-6': 20,
    'F-5': 5,
    'F-4': 20,
    'F-3': 5,
    'F-2': 15,
    'F-1': 15
  };

  static const Map<String,String> dict = {
    'Preparation-': 'Preparation',
    'Checking-':    'Checking',
    'S-13-C':       'Spotting Aisle 13 - cleaning',
    'S-13-P':       'Spotting Aisle 13 - pet', // breaking, aisle 13, pet side
    'T-13-C':       'Throwing Aisle 13 - cleaning',
    'T-13-P':       'Throwing Aisle 13 - pet',
    'C-13':         'Cleanup Aisle 13',
    'T-6':          'Throwing Aisle 6',
    'C-6':          'Cleanup Aisle 6',
    'T-5':          'Throwing Aisle 5',
    'T-4':          'Throwing Aisle 4',
    'C-4':          'Cleanup Aisle 4',
    'T-12':         'Throwing Aisle 12',
    'Rest-':        'Lunch time',
    'F-13':         'Facing Aisle 13',
    'F-12':         'Facing Aisle 12',
    'F-11':         'Facing Aisle 11',
    'F-10':         'Facing Aisle 10',
    'F-9':          'Facing Aisle 9',
    'F-8':          'Facing Aisle 8',
    'F-7':          'Facing Aisle 7',
    'F-6':          'Facing Aisle 6',
    'F-5':          'Facing Aisle 5',
    'F-4':          'Facing Aisle 4',
    'F-3':          'Facing Aisle 3',
    'F-2':          'Facing Aisle 2',
    'F-1':          'Facing Aisle 1',
  };

  static const List<String> agenda = [
    'Preparation-',
    'Checking-',
    'S-13-C',
    'S-13-P', // breaking, aisle 13, pet side
    'T-13-C',
    'T-13-P',
    'C-13',
    'T-6',
    'C-6',
    'T-5',
    'T-4',
    'C-4',
    'T-12',
    'Rest-',
    'F-13',
    'F-12',
    'F-10',
    'F-9',
    'F-8',
    'F-7',
  ];
}

class TaskWidget extends StatefulWidget {
  final Task task;
  TaskWidget({@required this.task});
  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    Duration t = widget.task.watch.elapsed;
    String sub = Task.dict[widget.task.id];
    if(widget.task.startTime != null) sub += "\nStarted: " + widget.task.startTime.toString().split('.')[0].split(' ')[1];
    return Container(
      child: Card(
        color: (widget.task.isActive()) ? Colors.greenAccent : Colors.white,
        child: ListTile(
          isThreeLine: true,
          title: TimerText(stopwatch: widget.task.watch,),
          // title: t==null? Text("00:00") : Text(t.toString().split('.')[0]),
          // String subtitle = "Started: " + widget.task.startTime.toString().split('.')[0].split(' ')[0]
          subtitle: Text(sub),
          trailing: CircleAvatar(
            child: Text(widget.task.loadSize.toString()),
          ),
          onTap: handleOntap,
          onLongPress: () => handleLongpress(context),
        ),
      ),
    );
  }

  void handleOntap() {
    setState(() => widget.task.toggle());
  }
  void handleLongpress(BuildContext context) async {
    // long press to edit load size    
    Duration currentDur = new Duration(minutes: widget.task.loadSize);
    Duration newDuration = await showDurationPicker(
      context: context,
      initialTime: currentDur,
    );
    int newSize = newDuration.inMinutes;
    Scaffold.of(context).showSnackBar(new SnackBar(content: Text('Set duration: $newSize minutes'),));
    setState(() {
      widget.task.loadSize = newSize;
    });
  }
}
