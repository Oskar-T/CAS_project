import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class WordOfTheDay extends StatefulWidget {
  WordOfTheDay({Key key}) : super(key: key);

  @override
  _WordOfTheDayState createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<WordOfTheDay> {
  Future<String> func() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.dictionary.com/e/word-of-the-day/"));

    var document = parse(response.body);
    var elem = document.getElementsByClassName("otd-item-headword__word");
    String str = elem[0].text;
    print(str);

    var elem2 = document.getElementsByClassName("otd-item-headword__pos");
    var str2 = elem2[0].getElementsByTagName("p");
    print(str2[1].text);

    return str;
  }

  Future<String> func2() async {
    final response = await http.Client()
        .get(Uri.parse("https://www.dictionary.com/e/word-of-the-day/"));

    var document = parse(response.body);

    var elem2 = document.getElementsByClassName("otd-item-headword__pos");
    var str2 = elem2[0].getElementsByTagName("p");
    print(str2[1].text);

    return str2[1].text;
  }

  Future<String> _bar;
  Future<String> _bar2;

  void word(var response) {
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var elem = document.getElementsByClassName("otd-item-headword__word");
      String str = elem[0].text;
      print(str);
    } else {
      throw Exception;
    }
  }

  @override
  void initState() {
    super.initState();
    _bar = func();
    _bar2 = func2();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
                colors: [Color(0xFF7777C0), Color(0xFF8A7CD4)])
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.25,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Word of the day", style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0
                ),),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child: FutureBuilder<String>(
                            future: _bar,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData) {
                                return Container(
                                  child: Text(
                                    ('${snapshot.data}'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15.0),
                                  ),
                                );
                              } return Center(child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ));
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: FutureBuilder(
                            future: _bar2,
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData) {
                                return Container(
                                  child: Text(
                                    ('${snapshot.data}'),
                                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                                  ),
                                );
                              }
                              return Center(child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ));
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}