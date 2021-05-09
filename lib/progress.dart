import 'package:flutter/material.dart';

import 'appbar.dart';
import 'blockchain.dart';
import 'dialogbox.dart';
import 'drawer.dart';

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Progresspage(),
    );
  }
}

class Progresspage extends StatefulWidget {
  @override
  _ProgresspageState createState() => _ProgresspageState();
}

class _ProgresspageState extends State<Progresspage> {
   final _addProgressFormkey = GlobalKey<FormState>();
  String patientid,description,con_date;
  bool agreedToTerms = false;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  BlockChain blockChain = BlockChain();
  TextEditingController datectl = TextEditingController();

  @override
  Widget build(BuildContext context) {
      double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: pulldrawer(context, 4),
      appBar: curvedappBar(_key),      
      body: Form(
        key: _addProgressFormkey,
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Center(
                  child: Text("Patient's Progress",
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
                    if (value.isEmpty)
                      return "Description can't be empty";                    
                  },
                  decoration: InputDecoration(
                    filled: true,
                    //hintText: 'i.e. a person, place or thing',
                    labelText: "Enter Progress Description",
                  ),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                //3
                TextFormField(
                controller: datectl,
                onChanged: (val) {
                  con_date = val;
                  print(con_date);
                },
                decoration: InputDecoration(
                    filled: true,
                    //hintText: 'e.g. quick, beautiful, interesting',
                    labelText: "Date of Consultation",
                  ),
                onTap: () async {
                  DateTime date = DateTime(1900);
                  FocusScope.of(context)
                      .requestFocus(new FocusNode());

                  date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  datectl.text =
                      date.toIso8601String().split('T')[0];
                      print(datectl.text+"ddd");
              }),
        
                // 4
                FormField(
                  initialValue: false,
                  validator: (value) {
                    if (value == false) {
                      return 'You must agree to the terms of service.';
                    }
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
                            _addProgressFormkey.currentState.reset();
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
                            if (!_addProgressFormkey.currentState.validate()) {
                            } else {
                               //print("\n"+description);
                              // print("\n"+date);
                              print("\n"+patientid+"\n"+description+"\n"+datectl.text);
                              blockChain.setRecord(description,datectl.text,patientid);
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