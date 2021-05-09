import 'package:mongo_dart/mongo_dart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sms_me/ScanQR.dart';

//import 'ScanQR.dart';
Future<Album> fetch_spokedetails(int spokeid, int hubid) async {
  var decodedData;
  //var ontime;

  final http.Response response = await http.post(
    Uri.parse('https://sms-med.herokuapp.com/api/deviceinfo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'spokeid': spokeid,
      'hubid': hubid,
    }),
  );
  if (response.statusCode == 200) {
    var data = response.body;
    decodedData = jsonDecode(data);
    print(
        "--------------------------- data:$decodedData---------------------------"); //"status": "Success"
    spokesid = decodedData['spokeid'];
    ontime = decodedData['ontime'];
    offtime = decodedData['offtime'];
    workeddate = decodedData['date'];
    count = 1;
  }
}

class Album {
  final int spokeid;
  final int hubid;

  Album({this.spokeid, this.hubid});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      spokeid: json['spokeid'],
      hubid: json['hubid'],
    );
  }
}
