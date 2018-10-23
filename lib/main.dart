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
        primarySwatch: Colors.blue,
        fontFamily: 'Lato',
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
      // backgroundColor: Theme.of(context).,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sync),
            onPressed: () => _syncFirestore(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              String taskData = Task.agenda[index];
              Task t = new Task(id: taskData);
              return TaskWidget(task: t);
            },
            // itemExtent: 128.0,
            itemCount: Task.agenda.length,
          ),
        ),
      ),
    );
  }

  void _syncFirestore() {
    print('syncing..');
    print(new DateTime.now().toString());
  }
}
