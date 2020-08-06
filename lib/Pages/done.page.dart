import 'package:flutter/material.dart';
import 'package:vaudience/Components/header.dart';
import 'package:vaudience/Pages/configuration.page.dart';

class DonePage extends StatefulWidget {
  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, titleText: 'Congratulations'),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).accentColor,
        ], begin: FractionalOffset(0.3, 0.1), end: FractionalOffset(0.5, 0.6))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'DONE',
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.blueGrey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfigurationPage(),
                      ),
                    );
                  },
                  child: Text('Train Again'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
