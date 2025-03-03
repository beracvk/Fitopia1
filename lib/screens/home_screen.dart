// ignore_for_file: file_names, depend_on_referenced_packages, duplicate_import

import 'package:fitopia2/screens/second_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 110, 141, 80),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                radius: 95.0,
                backgroundColor: Colors.green.shade900,
                backgroundImage: AssetImage('assets/images/fitopia.jpg'),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondScreen()),
                  );
                },
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
    );
  }
}
