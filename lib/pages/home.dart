// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api
import 'dart:convert';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    Map data = jsonDecode(jsonEncode(args));
    print(data);

    String bgImageVersion = 'v1';
    //set background
    String bgImage = data['isDayTime']
        ? 'day-$bgImageVersion.png'
        : 'night-$bgImageVersion.png';

    Color? bgColor = data['isDayTime'] ? Colors.blue[600] : Colors.indigo[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                onPressed: () => {Navigator.pushNamed(context, '/location')},
                label: Text("Edit Location",
                    style: TextStyle(color: Colors.black)),
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    data['location'],
                    style: TextStyle(fontSize: 28.0, letterSpacing: 2.0),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(fontSize: 66),
              )
            ],
          ),
        ),
      )),
    );
  }
}
