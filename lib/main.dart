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
}
