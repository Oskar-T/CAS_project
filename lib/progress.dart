import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Progress extends StatefulWidget {
  Progress({Key key}) : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  String progressCounter = "";

  Future<int> _getIntFromSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    final startupNumber = prefs.getInt('startupNumber');
    if (startupNumber == null) {
      return 0;
    }
    return startupNumber;
  }

  Future<void> _incrementStartup() async {
    final prefs = await SharedPreferences.getInstance();

    int lastStartupNumber = await _getIntFromSharedPref();
    int currentStartupNumber = lastStartupNumber++;

    await prefs.setInt('startupNumber', currentStartupNumber);

    setState(() => progressCounter =
    'You are using this app for the $currentStartupNumber time! Keep learning more!');
  }

  @override
  void initState() {
    super.initState();
    _incrementStartup();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            progressCounter,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF4B5672),
                fontSize: 25.0),
          ),
        ),
      ),
    );
  }
}