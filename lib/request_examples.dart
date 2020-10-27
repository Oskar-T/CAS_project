import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:words/ui/main.dart';

Future<dynamic> fetchExamples(String word) async {

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'x-rapidapi-host' : 'wordsapiv1.p.rapidapi.com',
    'x-rapidapi-key': 'fa1c05273fmshf909e1f944fc61dp11ef7djsn36eafab12b7b',

  };

  final response = await
  http.get('https://wordsapiv1.p.rapidapi.com/words/$word/examples/',
      headers: requestHeaders);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }

}


class Example {
  Example({
    this.word,
    this.examples,
  });

  String word;
  List<String> examples;

  factory Example.fromJson(Map<String, dynamic> json) => Example(
    word: json["word"],
    examples: List<String>.from(json["examples"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "examples": List<dynamic>.from(examples.map((x) => x)),
  };
}