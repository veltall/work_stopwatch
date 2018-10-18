import 'package:flutter/material.dart';
import 'task.dart';

void main() => runApp(new WorkTimerApp());

class WorkTimerApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Work Tools',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new StopwatchHomeScreen(),
    );
  }
}

class StopwatchHomeScreen extends StatefulWidget {
  @override
  _StopwatchHomeScreenState createState() => _StopwatchHomeScreenState();
}

class _StopwatchHomeScreenState extends State<StopwatchHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var title = 'Gotta Go Fast';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: null,
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          String taskData = Task.agenda[index];
          Task t = new Task(id: taskData);
          return TaskWidget(task: t);
        },
        itemExtent: 100.0,
        itemCount: Task.agenda.length,
      ),
    );
  }
}

// class StopwatchApp extends StatefulWidget {
//   final List<String> tasks = <String>[];
//   StopwatchApp({title: String}) {
//     initializeTaskList();
//   }

//   @override
//   _StopwatchAppState createState() => _StopwatchAppState();

//   void initializeTaskList() {
//     tasks.add('PREP:        pulling board');
//     tasks.add('EXTRA:       checking');
//     tasks.add('BREAKDOWN:   cleaning');
//     tasks.add('STOCK:       cleaning');
//     tasks.add('BREAKDOWN:   pet');
//     tasks.add('STOCK:       pet');
//     tasks.add('CLEANUP:     #1');
//     tasks.add('STOCK:       aisle 6');
//     tasks.add('CLEANUP:     #2');
//     tasks.add('STOCK:       aisle 5+4');
//     tasks.add('CLEANUP:     #3');
//     tasks.add('FACE:        13');
//     tasks.add('FACE:        12');
//     tasks.add('FACE:        10');
//     tasks.add('FACE:        9');
//     tasks.add('FACE:        8');
//     tasks.add('FACE:        7');
//   }
// }

// class _StopwatchAppState extends State<StopwatchApp> {
//   final List<Stopwatch> watches = <Stopwatch>[];

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: AppBar(
//         title: Text('Gotta Go Fast'),
//       ),
//       body: ListView.builder(
//         itemCount: widget.tasks.length,
//         itemBuilder: (BuildContext context, int count) {
//           watches.add(new Stopwatch());
//           bool active = !watches.elementAt(count).paused;
//           return Container(
//             height: 100.0,
//             child: Card(
//               margin: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: ListTile(
//                 title: Text(
//                   watches.elementAt(count).elapseString(),
//                   style: Theme.of(context).textTheme.headline,
//                 ),
//                 subtitle: Text(widget.tasks.elementAt(count)),
//                 trailing: CircleAvatar(
//                     child: Text(widget.tasks[count].substring(0, 1))),
//                 onTap: () => toggleStopwatch(count),
//               ),
//               color: active ? Colors.greenAccent : Colors.white,
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 10.0),
//           );
//         },
//       ),
//     );
//   }

//   void toggleStopwatch(int index) {
//     setState(() {
//       watches.elementAt(index).toggle();
//     });
//   }
// }
