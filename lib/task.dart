import 'package:meta/meta.dart';

enum task_type { preparation, checking, spotting, throwing, cleaning, resting, facing }
enum performance { ahead, behind, ontime, unknown }

class Task {
  String id;
  int loadSize;
  task_type type;
  DateTime startTime; // documentary purposes
  DateTime finishTime;
  Duration adjustedTimeAllocation; // projected based on work load
  Duration actualTime; // measured with stopwatch
  performance result;
  bool started;
  bool finished;
  Stopwatch watch;

  // example initiation: new Task(id: "T-13C", loadSize: 78)
  Task({@required String id, int loadSize}) {
    startTime = null; finishTime = null; actualTime = null;
    result = performance.unknown;
    started = false; finished = false;
    watch = new Stopwatch();

    this.id = id;
    this.loadSize = loadSize != null ? loadSize : GOAL_TIMES[id];   // default to goal times
    this.adjustedTimeAllocation = new Duration(minutes: loadSize);
    var tasktype = id.split('-')[0];
    switch(tasktype) {
      case 'Preparation': this.type = task_type.preparation; break;
      case 'Checking':    this.type = task_type.checking; break;
      case 'S':           this.type = task_type.spotting; break;
      case 'T':           this.type = task_type.throwing; break;
      case 'C':           this.type = task_type.cleaning; break;
      case 'R':           this.type = task_type.resting; break;
      case 'F':           this.type = task_type.facing; break;
      default:            this.type = task_type.resting; break;
    }
  }

  updateLoadSize(int newSize) {
    this.loadSize = newSize;
    this.adjustedTimeAllocation = new Duration(minutes: loadSize);
  }

  start() {
    if(!started) {
      startTime = new DateTime.now(); started = true;
      watch.start();
    }
  }

  // in minutes
  static const Map<String, int> GOAL_TIMES = {
    'Preparation': 20,
    'Checking': 30,
    'S-13C': 20,
    'S-13P': 10, // breaking, aisle 13, pet side
    'T-13C': 50,
    'T-13P': 20,
    'C-13': 15,
    'T-6': 30,
    'C-6': 10,
    'T-5': 5,
    'T-4': 20,
    'C-4': 5,
    'T-12': 20,
    'Rest': 30,
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

  static const List<String> agenda = [
    'Preparation',
    'Checking',
    'B-13C',
    'B-13P', // breaking, aisle 13, pet side
    'T-13C',
    'T-13P',
    'C-13',
    'T-6',
    'C-6',
    'T-5',
    'T-4',
    'C-4',
    'T-12',
    'Rest',
    'F-13',
    'F-12',
    'F-10',
    'F-9',
    'F-8',
    'F-7',
  ];
}
