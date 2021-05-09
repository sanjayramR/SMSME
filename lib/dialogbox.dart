import 'package:flutter/material.dart';
import 'package:sms_me/ScanQR.dart';

Future dialogBox(var text, bool error, double screenheight, double screenwidth,
    int popcount, BuildContext context, var buttonstring) {
  return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(0.0, 1.0))
              ],
            ),
            width: screenwidth,
            height: screenheight,
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Center(
                      child: (error)
                          ? Text(
                              "Error",
                              style: TextStyle(
                                  color: Colors.red[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          : Text(
                              "Done",
                              style: TextStyle(
                                  color: Colors.blue[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )),
                  SizedBox(
                    height: 10,
                  ),
                  Icon(
                    (error) ? Icons.error : Icons.done,
                    size: 40,
                    color: (error) ? Colors.red : Colors.green,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: Text(text, style: TextStyle(fontSize: 15))),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    color: Colors.lightBlue[800],
                    child: Text(buttonstring,
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      print("popcount:  $popcount");
                        for (int i = 0; i < popcount; i++)
                          Navigator.of(context).pop(); 
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => ScanQR()));
                    },
                  )
                ])),
          ),
        );
      });
}
