import 'package:flutter/material.dart';
import '../Services/getdata.service.dart';

class QuoteComponent extends StatefulWidget {
  @override
  _QuoteComponentState createState() => _QuoteComponentState();
}

Text loadQuote(snapshot) {
  return Text(
    snapshot.data == null ? '' : snapshot.data,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 28.0),
  );
}

class _QuoteComponentState extends State<QuoteComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchQuote(),
      builder: (context, snapshot) {
        return loadQuote(snapshot) == null
            ? 'Loading...'
            : loadQuote(snapshot);
      },
    );
  }
}
