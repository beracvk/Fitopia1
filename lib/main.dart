import 'package:flutter/material.dart';

void main() {
  runApp(
     MyApp(),
    );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green.shade900,
        body: SafeArea(child: Center(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              radius: 95.0,
              backgroundColor: Colors.green.shade900,
              backgroundImage: AssetImage('assets/images/fitopia.jpg'),
            ),
         IconButton(onPressed: () {}, 
             icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
              size: 30,
              ),
              ),
          ],
        ),
        ),
      ),
    ),
    );
  }
}




