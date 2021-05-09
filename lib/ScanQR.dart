import 'package:flutter/material.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:sms_me/blockchain.dart';

import 'appbar.dart';
import 'database.dart';
import 'drawer.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

String qrresult = "please click Scan Barcode to view spoke specific data";
String ontime = "";
String offtime = "";
String spokesid = "";
String workeddate = "";
int count = 0;

class _ScanQRState extends State<ScanQR> {
  BlockChain blockChain = BlockChain();
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    blockChain.getPatientDetails("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: pulldrawer(context, 0),
      key: _key,
      appBar: //AppBar(title: Text("Scan QR"),)
          curvedappBar(_key),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Scanned Details:",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            (qrresult ==
                    "please click Scan Barcode to view spoke specific data")
                ? Column(
                    children: [
                      (count == 0)
                          ? Text(
                              qrresult,
                              style: TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            )
                          : CircularProgressIndicator(),
                    ],
                  )
                : (ontime != "")
                    ? Container(
                        padding: EdgeInsets.all(10),
                        child: Material(
                            color: Colors.white,
                            elevation: 14.0,
                            borderRadius: BorderRadius.circular(24.0),
                            shadowColor: Color(0x802196F3),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Spokeid : $spokesid",
                                    style: TextStyle(fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "LastOnTime :$ontime",
                                    style: TextStyle(fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "LastOffTime : $offtime",
                                    style: TextStyle(fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "LastWorkedDate : $workeddate",
                                    style: TextStyle(fontSize: 18.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )),
                      )
                    : Column(
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
            SizedBox(height: 20.0),
            RaisedButton(
              padding: EdgeInsets.all(15),
              onPressed: () async {
                var scannerResult = "";
                //  try{
                setState(() {
                  count = 1;
                });

                try {
                  scannerResult = await BarcodeScanner.scan();
                } catch (Exception) {
                  setState(() {
                    qrresult =
                        "please click Scan Barcode to view spoke specific data";
                    count = 0;
                  });
                  //  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ScanQR()));
                }
                await fetch_spokedetails(int.parse(scannerResult), 1);
                setState(() {
                  qrresult = "";
                });

                //  }
                //  catch(Exception){
                //       setState(() {
                //         qrresult = "please click Scan Barcode to view spoke specific data";
                //         count = 0;
                //       });
                //       Navigator.of(context).pop();
                //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanQR()));
                //  }
              },
              child: Text(
                "Scan Barcode",
                style: TextStyle(color: Colors.indigo[900]),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Colors.indigo[900],
                  ),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }
}
