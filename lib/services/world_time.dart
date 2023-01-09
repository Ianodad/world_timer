import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; // selected location from
  late String time; // the time in that location

  late String flag; // url to an asset flag icon
  late String url; // location url for teh api endpoint

  late bool isDayTime;
  // true or false for day or night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      // print(data);

      String dateTime = data['datetime'];
      String utcOffset = data['utc_offset'].substring(1, 3);

      // print(datetime);

      // create DateTime object

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(utcOffset)));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (err) {
      print('Caught error: $err');
      time = "Could not find time";
    }
  }
}
