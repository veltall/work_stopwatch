import 'package:date_format/date_format.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Workday {
  final DateTime date;
  int loadSize;
  List<String> agenda;
  List<ActivityRecord> performance;
  final DocumentReference reference;

  Workday({this.date, this.reference});
  Workday.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['date'] != null),
      date = DateTime.parse(map['date']) {
        loadSize = map['load_size'];
        agenda = map['agenda'];
        List<Map<String, dynamic>> performanceMap = map['performance_record'];
        performance = performanceMap.map((recordMap){
          return new ActivityRecord.fromMap(recordMap);
        }).toList();
  }

  Workday.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  void test() {
    formatDate(this.date, [mm,dd,yyyy]);
  }
  void getDateTimeExample() {
    DateTime d = new DateTime.now();
    print(d.toString());
  }
}

// enum activityType {
//   preparation,
//   checking,
//   spotting,
//   throwing,
//   cleaning,
//   resting,
//   facing
// }

class ActivityRecord {
  final String id;
  String type;
  String target;
  int workLoad;
  Duration timeTaken;
  Duration goalTime;
  final DateTime startTime;

  ActivityRecord.fromMap(Map<String, dynamic> map)
    : assert(map['id'] != null),
      assert(map['start_time_ms_since_epoch'] != null),
      id = map['id'],
      startTime = new DateTime.fromMillisecondsSinceEpoch(map['start_time_ms_since_epoch']) {
        type = map['activity_type'];
        target = map['target'];
        workLoad = map['activity_load'];
        timeTaken = new Duration(minutes: map['time_taken_in_minutes']);
        goalTime  = new Duration(minutes: map['goal_time_in_minutes']);
  }

}