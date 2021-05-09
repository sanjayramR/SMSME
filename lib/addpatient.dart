import 'package:flutter/material.dart';
import 'package:sms_me/appbar.dart';
import 'package:sms_me/drawer.dart';

import 'blockchain.dart';
import 'dialogbox.dart';

class Addpatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Addpatientpage(),
    );
  }
}

class Addpatientpage extends StatefulWidget {
  @override
  _AddpatientpageState createState() => _AddpatientpageState();
}

class _AddpatientpageState extends State<Addpatientpage> {
  final _addPatientFormkey = GlobalKey<FormState>();
  String patientid,name,age,gender;
  bool agreedToTerms = false;
  int id = -1;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  BlockChain blockChain = BlockChain();

  @override
  Widget build(BuildContext context) {
      double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: pulldrawer(context, 2),
      appBar: curvedappBar(_key),      
      body: Form(
        key: _addPatientFormkey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text("Add new Patient",
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
                // 2
                TextFormField(
                  validator: (value) {
                    
                      Pattern pattern =
                                      r'^[ A-Za-z]+(?:[ _-][A-Za-z]+)*$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty)
                      return " Name can't be empty";
                    else if (!regex.hasMatch(value))
                      return 'Invalid  Name';
                    return null;
                    
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //hintText: 'i.e. a person, place or thing',
                    labelText: "Enter a Patient's Name",
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                //3
                TextFormField(
                  validator: (value) {
                    
                    Pattern pattern = r'^[0-9]+(\.[0-9][0-9]?)?$';
                    RegExp regex = new RegExp(pattern);
                    if (value.isEmpty)
                      return " Age can't be empty";
                    else if (!regex.hasMatch(value))
                      return 'Invalid  Age';
                    return null;
                    
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //hintText: 'i.e. a person, place or thing',
                    labelText: "Enter Patient's Age",
                  ),
                  onChanged: (value) {
                    age = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                // 4
                 Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            SizedBox(width: 30),
                            Radio(
                              value: 1,
                              groupValue: id,
                              onChanged: (value) {
                                setState(() {
                                  gender = "male";
                                  id = 1;
                                });
                              },
                            ),
                            Text("Male"),
                            SizedBox(width: 50),
                            Radio(
                              value: 2,
                              groupValue: id,
                              onChanged: (value) {
                                setState(() {
                                  gender = "female";
                                  id = 2;
                                });
                              },
                            ),
                            Text("Female"),
                          ],
                        ),
                      ),
                SizedBox(
                  height: 24,
                ),
                //5
                FormField(
                  initialValue: false,
                  validator: (value) {
                    if (value == false) {
                      return 'You must agree to the terms of service.';
                    }
                    return null;
                  },
                  builder: (FormFieldState formFieldState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) {
                                // When the value of the checkbox changes,
                                // update the FormFieldState so the form is
                                // re-validated.
                                formFieldState.didChange(value);
                                setState(() {
                                  agreedToTerms = value;
                                });
                              },
                            ),
                            Text(
                              'I agree that the above details are true.',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        if (!formFieldState.isValid)
                          Text(
                            formFieldState.errorText ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).errorColor),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 24,
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
                            _addPatientFormkey.currentState.reset();
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
                          onPressed: () {
                            if (!_addPatientFormkey.currentState.validate()) {
                            } else {
                              print("\n"+patientid+"\n"+name+"\n"+age);//+"\n"+age);
                              blockChain.setPatientDetails(patientid,name,age,gender);
                                dialogBox(
                                    "Patient's details added successfully",
                                    false,
                                    (_width/100)*75,
                                    (_width/100)*75,
                                    2,
                                    context,
                                    "Done");
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
  }}