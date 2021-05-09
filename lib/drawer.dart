import 'package:flutter/material.dart';
import 'package:sms_me/addpatient.dart';
import 'package:sms_me/medicine.dart';
import 'package:sms_me/patientsdetails.dart';
import 'package:sms_me/progress.dart';

import 'ScanQR.dart';


Widget pulldrawer(BuildContext context, int option) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        //1
        Container(
          child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xff7b1fa2), const Color(0xff18ffff)],
                  tileMode: TileMode.repeated,
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 45, 5, 3),
                child: Text(
                  "Greetings!\nWelcome to the site",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Segoe UI'),
                ),
              )),
        ),

        //2
        ListTile(
          leading: Icon(Icons.devices, color: Colors.black),
          title: Text("Scan QR",
              style: TextStyle(
                  color: (option == 1) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ScanQR()));
          },
        ),

        //3
        ListTile(
          leading: Icon(Icons.person_add_sharp, color: Colors.black),
          title: Text("Add new Patient",
              style: TextStyle(
                  color: (option == 2) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Addpatient()));
          },
        ),

        //4
        ListTile(
          leading: Icon(Icons.paste_sharp, color: Colors.black),
          title: Text("Patient's Medicine Update",
              style: TextStyle(
                  color: (option == 3) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Medicine()));
          },
        ),

        //5
        ListTile(
          leading: Icon(
            Icons.bar_chart_sharp,
            color: Colors.black,
          ),
          title: Text("Patient's Progress",
              style: TextStyle(
                  color: (option == 4) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Progress()));
          },
        ),

        //6
        ListTile(
          leading: Icon(Icons.chat_rounded, color: Colors.black),
          title: Text("View Patient's Details",
              style: TextStyle(
                  color: (option == 5) ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI')),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Patientsdetails()));
          },
        ),

      ],
    ),
  );
}
