import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaudience/Components/header.dart';
import 'package:vaudience/Pages/working.page.dart';
import 'package:vaudience/Services/getdata.service.dart';

class ConfigurationPage extends StatefulWidget {
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

Text loadQuote(snapshot) {
  return Text(
    snapshot.data == null ? '' : snapshot.data,
    style: TextStyle(fontSize: 28.0),
  );
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String trainingIntervals;
    String durationTimeInterval;
    String durationBreakInterval;

    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text("Hey easy man!", textAlign: TextAlign.center,),
            content: Text("You need to enter numbers in all fields.", textAlign: TextAlign.center,),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
            elevation: 2,
          );
        },
      );
    }

    return Scaffold(
      appBar: header(context, titleText: "VAudience"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                  future: fetchQuote(),
                  builder: (context, snapshot) {
                    return loadQuote(snapshot) == null
                        ? 'Loading...'
                        : loadQuote(snapshot);
                  },
                ),
                Divider(
                  height: 120.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter training intervals',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter training intervals';
                    }
                    return null;
                  },
                  onSaved: (value) => trainingIntervals = value,
                ),
                Divider(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter training duration',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter training duration';
                    }
                    return null;
                  },
                  onSaved: (value) => durationTimeInterval = value,
                ),
                Divider(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter break duration',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter break duration';
                    }
                    return null;
                  },
                  onSaved: (String value) => durationBreakInterval = value,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      try {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          if (int.parse(trainingIntervals) is int &&
                              int.parse(durationTimeInterval) is int &&
                              int.parse(durationBreakInterval) is int) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkingPage(
                                  trainingIntervals: trainingIntervals,
                                  durationTimeInterval: durationTimeInterval,
                                  durationBreakInterval: durationBreakInterval,
                                ),
                              ),
                            );
                          }
                        }
                      } catch(e) {
                        _showDialog();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
