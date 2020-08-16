import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vaudience/Components/header.dart';
import 'package:vaudience/Pages/done.page.dart';

class WorkingPage extends StatefulWidget {
  String trainingIntervals;
  String durationTimeInterval;
  String durationBreakInterval;
  int nextSession = 0;
  Duration currentSessionTime;
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
  List data = [];
  Timer _timer;
  int _counter;
  bool isPaused = false;
  int pausedTime;
  bool isWorking;

  void _startTimer() {
    if(_timer != null) {
      _timer.cancel();
      _timer = null;
      isPaused = true;
      pausedTime = _counter;
      isWorking = true;
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          isPaused = false;
          isWorking = false;
          if(_counter > 0) {
            _counter--;
          } else if(widget.nextSession <= widget.numberOfSessions) {
            widget.nextSession++;
            print("123");
            _counter = this.data[widget.nextSession]['time'];
            if(widget.numberOfSessions - widget.nextSession == 1) {
              print("123");
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

  restartSession() {
    _timer.cancel();
    _counter = 0;
    Navigator.of(context).pop();
  }

  @override
  initState() {
    super.initState();
    for (int i = 0; i < int.parse(widget.trainingIntervals); i++) {
      this.data.add({
        'color': Colors.green,
        'duration': Duration(minutes: int.parse(widget.durationTimeInterval)),
        'time': int.parse(widget.durationTimeInterval) * 60,
        'count': i + 1,
        'working': 'Working'
      });
      this.data.add({
        'color': Colors.red,
        'duration': Duration(minutes: int.parse(widget.durationBreakInterval)),
        'time': int.parse(widget.durationBreakInterval) * 60,
        'count': i + 1,
        'working': 'Break'
      });
    }
    widget.numberOfSessions = this.data.length;
    _counter = this.data[widget.nextSession]['time'];
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
            statusAndCountdown(context, this.data[widget.nextSession]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                isWorking == false
                    ? button(context, Icons.pause, startStopSession)
                    : button(context, Icons.play_arrow, startStopSession),
                button(context, Icons.stop, restartSession)
              ],
            ),
          ],
        ),
      ),
    );
  }

  timeToMinutesSeconds(time) {
    return "${((time != null ? time~/60: '') ).toString()} : ${(time != null ?( time % 60).toInt(): '').toString()}";
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
          isPaused == false ? timeToMinutesSeconds(_counter) : timeToMinutesSeconds(pausedTime),
          style: TextStyle(
            fontSize: 50,
          ),
        ),
      ),
    );
  }

  Column statusAndCountdown(context, data) {
    return Column(
      children: <Widget>[
        currentStageOfTraining(context, data),
        countdownTtime(context, data)
      ],
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
