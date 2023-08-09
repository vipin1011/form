


import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String username;
  final String gender;
  final bool notification;

  const SuccessScreen({super.key, required this.username, required this.gender,required this.notification,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: MediaQuery.of(context).size.width,),
          Spacer(),
          Text('Welcome, $username!'),
          Spacer(),
          Text('Gender - $gender'),
          Text('Notifications - ${notification? 'ON': 'OFF'}'),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            color: Colors.black,
              child: Text('On pressing back, state will be automatically cleared!', style: TextStyle(color: Colors.white),)),
          Spacer(),
        ],
      )
    );
  }
}