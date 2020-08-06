import 'package:flutter/material.dart';
import 'package:vaudience/Pages/configuration.page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfigurationPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Image.asset("assets/images/vaudience.png"),
        ),
        Container(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        )
      ],
    );
  }
}
