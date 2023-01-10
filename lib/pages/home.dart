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
    final args =
        data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments;
    data = jsonDecode(jsonEncode(args));
    print(data);

    String bgImageVersion = 'v1';
    //set background
    String bgImage = data['isDayTime']
        ? 'day-$bgImageVersion.png'
        : 'night-$bgImageVersion.png';

    Color? bgColor = data['isDayTime'] ? Colors.blue[600] : Colors.indigo[900];

    Color? locationColor =
        data['isDayTime'] ? Colors.orange[600] : Colors.white;

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
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time': result['time'],
                      'location': result['location'],
                      'flag': result['flag'],
                      'isDayTime': result['isDayTime'],
                    };
                  });
                },
                label: Text("Edit Location",
                    style: TextStyle(color: locationColor)),
                icon: Icon(
                  Icons.edit_location,
                  color: locationColor,
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
                style: TextStyle(fontSize: 66, shadows: const [
                  Shadow(
                      // bottomLeft
                      offset: Offset(-1.5, -1.5),
                      color: Colors.white),
                  Shadow(
                      // bottomRight
                      offset: Offset(1.5, -1.5),
                      color: Colors.white),
                  Shadow(
                      // topRight
                      offset: Offset(1.5, 1.5),
                      color: Colors.white),
                  Shadow(
                      // topLeft
                      offset: Offset(-1.5, 1.5),
                      color: Colors.white),
                ]),
              )
            ],
          ),
        ),
      )),
    );
  }
}
