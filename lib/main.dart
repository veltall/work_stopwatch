import 'package:flutter/material.dart';
import 'stopwatch.dart';

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
      home: new StopwatchApp(title: 'Custom Stopwatch'),
    );
  }
}

class StopwatchApp extends StatefulWidget {
  final List<String> tasks = new List<String>();
  StopwatchApp({title: String}) {
    initializeTaskList();
  }
      
  @override
  _StopwatchAppState createState() => _StopwatchAppState();
    
  void initializeTaskList() {
    tasks.add('PREP:        pulling board');
    tasks.add('BREAKDOWN:   cleaning');
    tasks.add('STOCK:       cleaning');
    tasks.add('BREAKDOWN:   pet');
    tasks.add('STOCK:       pet');
    tasks.add('CLEANUP:     #1');
    tasks.add('STOCK:       aisle 6');
    tasks.add('CLEANUP:     #2');
    tasks.add('STOCK:       aisle 5+4');
    tasks.add('CLEANUP:     #3');
    tasks.add('FACE:        13');
    tasks.add('FACE:        12');
    tasks.add('FACE:        10');
    tasks.add('FACE:        9');
    tasks.add('FACE:        8');
    tasks.add('FACE:        7');
  }
}

class _StopwatchAppState extends State<StopwatchApp> {
  final List<Stopwatch> watches = new List<Stopwatch>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Gotta Go Fast'),
      ),
      body: ListView.builder(
        itemCount: 14,
        itemBuilder: (BuildContext context, int count) {
          watches.add(new Stopwatch());
          bool active = !watches.elementAt(count).paused;
          return Container(
            height: 100.0,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListTile(
                title: Text(watches.elementAt(count).elapseString(), 
                        style: Theme.of(context).textTheme.headline,),
                // subtitle: watches.elementAt(count).name,
                trailing: CircleAvatar(child: Text((count + 1).toString())),
                onTap: () => toggleStopwatch(count),
              ),
              color: active ? Colors.lightGreen : Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
          );
        },
      ),
    );
  }

  void toggleStopwatch(int index) {
    setState(() { 
      watches.elementAt(index).toggle();

    });
  }
}
