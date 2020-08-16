import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vaudience/Components/header.dart';
import 'package:vaudience/Pages/done.page.dart';
import 'package:vaudience/models/session.model.dart';

class WorkingPage extends StatefulWidget {
  String trainingIntervals;
  String durationTimeInterval;
  String durationBreakInterval;
  int nextSession = 0;
  int numberOfSessions;

  WorkingPage({
    @required this.trainingIntervals,
    @required this.durationTimeInterval,
    @required this.durationBreakInterval,
  });

  @override
  _WorkingPageState createState() => _WorkingPageState();
}


class _WorkingPageState extends State<WorkingPage> {
  Timer _timer;
  List data = [];
  bool isWorking;
  int _counter;
  int pausedTime;

  @override
  initState() {
    super.initState();
    // bad way to mock data
    for (int i = 0; i < int.parse(widget.trainingIntervals); i++) {
      var sessionNumber = i + 1;
      int timeInterval = int.parse(widget.durationTimeInterval) * 60;
      int breakInterval = int.parse(widget.durationBreakInterval) * 60;
      Duration durationTimeInterval =
          Duration(minutes: int.parse(widget.durationTimeInterval));
      Duration durationBreakInterval =
          Duration(minutes: int.parse(widget.durationBreakInterval));

      this.data.add(Session(Colors.green, durationTimeInterval, timeInterval,
          sessionNumber, 'Working'));
      this.data.add(Session(Colors.red, durationBreakInterval, breakInterval,
          sessionNumber, 'Break'));
    }
    widget.numberOfSessions = this.data.length;
    _counter = this.data[widget.nextSession]['time'];
  }

  void _startTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      pausedTime = _counter;
      isWorking = true;
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          isWorking = false;
          if (_counter > 0) {
            _counter--;
          } else if (widget.nextSession <= widget.numberOfSessions) {
            widget.nextSession++;
            _counter = this.data[widget.nextSession]['time'];
            if (widget.numberOfSessions - widget.nextSession == 1) {
              _timer.cancel();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonePage(),
                ),
              );
            }
          }
        });
      });
    }
  }

  startStopSession() {
    setState(() {
      isWorking = false;
    });
    _startTimer();
  }

  stopSession() {
    setState(() {
      widget.nextSession = 0;
      _counter = this.data[0]['time'];
      _timer.cancel();
      isWorking = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
        context,
        titleText: "Keep working",
        backButton: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            currentStageOfTraining(context, this.data[widget.nextSession]),
            countdownTtime(context, this.data[widget.nextSession]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isWorking == false
                    ? button(context, Icons.pause, startStopSession)
                    : button(context, Icons.play_arrow, startStopSession),
                button(context, Icons.stop, stopSession)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding currentStageOfTraining(context, currentSession) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 10,
        right: 50,
        left: 50,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentSession['color'],
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "${currentSession['working'] + " " + currentSession['count'].toString()}",
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),
      ),
    );
  }

  timeToMinutesSeconds(time) {
    return "${((time != null ? time ~/ 60 : '')).toString()} : ${(time != null ? (time % 60).toInt() : '').toString()}";
  }

  Padding countdownTtime(context, data) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        bottom: 10,
        right: 50,
        left: 50,
      ),
      child: Container(
        alignment: Alignment.center,
        child: Text(
          isWorking == false
              ? timeToMinutesSeconds(_counter)
              : timeToMinutesSeconds(pausedTime),
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Padding button(context, icon, function) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: IconButton(
        onPressed: function,
        icon: Icon(
          icon,
          size: 55.0,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
