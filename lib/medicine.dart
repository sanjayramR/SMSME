import 'package:flutter/material.dart';
import 'package:sms_me/blockchain.dart';

import 'appbar.dart';
import 'dialogbox.dart';
import 'drawer.dart';

class Medicine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Medicinepage()
    );
  }
}
class Medicinepage extends StatefulWidget {
  @override
  _MedicinepageState createState() => _MedicinepageState();
}

class _MedicinepageState extends State<Medicinepage> {
  final _addMedicineFormkey = GlobalKey<FormState>();
  String patientid,medicinename,dosage;
  bool agreedToTerms = false;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  BlockChain blockChain = BlockChain();

  @override
  Widget build(BuildContext context) {
      double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: pulldrawer(context, 3),
      appBar: curvedappBar(_key),      
      body: Form(
        key: _addMedicineFormkey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text("Medicine Update",
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
                      return " Medicine Name can't be empty";
                    else if (!regex.hasMatch(value))
                      return 'Invalid  Medicine Name';
                    return null;
                    
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //hintText: 'i.e. a person, place or thing',
                    labelText: "Enter a Medicine Name",
                  ),
                  onChanged: (value) {
                    medicinename = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                //3
                TextFormField(
                  validator: (value) {
                   
                    if (value.isEmpty)
                      return " doseage can't be empty";
                    
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //hintText: 'i.e. a person, place or thing',
                    labelText: "Enter Medicine Dosage",
                  ),
                  onChanged: (value) {
                    dosage = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                // 4

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
                            _addMedicineFormkey.currentState.reset();
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
                            if (!_addMedicineFormkey.currentState.validate()) {
                            } else {
                              blockChain.setMedicine(medicinename,dosage,patientid);
                                dialogBox(
                                    "Medicine details added successfully",
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
  }
}