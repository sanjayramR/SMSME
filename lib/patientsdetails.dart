import 'package:flutter/material.dart';
import 'package:sms_me/appbar.dart';
import 'package:sms_me/blockchain.dart';
import 'package:sms_me/dialogbox.dart';

import 'drawer.dart';

class Patientsdetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Patientsdetailspage()
    );
  }
}

class Patientsdetailspage extends StatefulWidget {
  @override
  _PatientsdetailspageState createState() => _PatientsdetailspageState();
}

class _PatientsdetailspageState extends State<Patientsdetailspage> {
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  final _patientdetailskey = GlobalKey<FormState>();
  BlockChain blockChain = BlockChain();
  String patientid;
  dynamic result;
  @override
   Widget build(BuildContext context) {
      double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: pulldrawer(context, 5),
      appBar: curvedappBar(_key),      
      body: Form(
        key: _patientdetailskey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text("Patients Details",
                            style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo
                            ),)),
                SizedBox(
                  height: 24,
                ),
                // 1
                TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Patient's id.";
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //hintText: 'e.g. quick, beautiful, interesting',
                    labelText: "Enter Patient's id",
                  ),
                  onChanged: (value) {
                    patientid = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                (result!=null)?Container(
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
                                  (result!=null)?Text(
                                    "Patient Name : ${result[0]}",
                                    style: TextStyle(fontSize: 18.0),
                                   // textAlign: TextAlign.center,
                                  ):Text(""),
                                  SizedBox(height: 5),
                                  (result!=null)?Text(
                                    "Patient Age : ${result[1]}",
                                    style: TextStyle(fontSize: 18.0),
                                   // textAlign: TextAlign.center,
                                  ):Text(""),
                                  SizedBox(height: 5),
                                  (result!=null)?Text(
                                    "Gender :${result[2]}",
                                    style: TextStyle(fontSize: 18.0),
                                    //textAlign: TextAlign.center,
                                  ):Text(""),
                                  SizedBox(height: 5),
                                  (result!=null)?Text(
                                    "Medicine given: ${result[3][0][0]}",
                                    style: TextStyle(fontSize: 18.0),
                                    //textAlign: TextAlign.center,
                                  ):Text(""),
                                  SizedBox(height: 5),
                                  (result!=null)?Text(
                                    "Dosage: ${result[3][0][1]}",
                                    style: TextStyle(fontSize: 18.0),
                                    //textAlign: TextAlign.center,
                                  ):Text(""),
                                  SizedBox(height: 5),
                                  (result!=null)?Text(
                                    "Progress : ${result[4][0][0]}",
                                    style: TextStyle(fontSize: 18.0),
                                    //textAlign: TextAlign.center,
                                  ):Text(""),
                                  SizedBox(height: 5),
                                  (result!=null)?Text(
                                    "Last Consultion : ${result[4][0][1]}",
                                    style: TextStyle(fontSize: 18.0),
                                    //textAlign: TextAlign.center,
                                  ):Text(""),
                                ],
                              ),
                            )),
                      ):Container(
                        child: Text("Invalid Patient Id",style: TextStyle(color: Colors.red,),)
                      ),
                    SizedBox(
                        width: 24
                      ),
               
              //Buttons
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonTheme(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.yellow[800],
                          child: Text("Cancel"),
                          onPressed: () {
                            _patientdetailskey.currentState.reset();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 24
                      ),
                      
                      ButtonTheme(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          color: Colors.lightBlue[800],
                          child: Text("Submit",
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            if (!_patientdetailskey.currentState.validate()) {
                            } else {
                              dynamic data = await blockChain.getPatientDetails(patientid);
                              setState(()  {
                              result = data;
                              if(result[0]=="")
                                result = null;
                              
                              });
                                                              
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}