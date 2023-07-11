import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter Value:',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '$counter',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: incrementCounter,
                    child: Text('+'),
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: decrementCounter,
                    child: Text('-'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
