import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Column(
        children: [

          // CONTAINER
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.blue,
            child: Text(
              "Welcome Raihan",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),

          // ROW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.home, size: 40),
              Icon(Icons.person, size: 40),
              Icon(Icons.settings, size: 40),
            ],
          ),

          // STACK
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                color: Colors.grey,
              ),
              Positioned(
                top: 30,
                left: 20,
                child: Text("Stack Example"),
              )
            ],
          ),

          // GRIDVIEW
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return Card(
                  child: Center(child: Text("Item $index")),
                );
              }),
            ),
          )
        ],
      ),
    );
  }
}