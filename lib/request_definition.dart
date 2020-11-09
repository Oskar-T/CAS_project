import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> fetchDefinition(String word) async {

  Map<String, String> requestHeaders = {
    'Accept': 'application/json',
    'x-rapidapi-host' : 'wordsapiv1.p.rapidapi.com',
    'x-rapidapi-key': '',

  };

  final response = await
  http.get('https://wordsapiv1.p.rapidapi.com/words/$word/definitions/',
      headers: requestHeaders);

  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load album');
  }

}

Words wordsFromJson(String str) => Words.fromJson(json.decode(str));

String wordsToJson(Words data) => json.encode(data.toJson());

class Words {
  Words({
    this.word,
    this.definitions,
  });

  String word;
  List<Definition> definitions;

  factory Words.fromJson(Map<String, dynamic> json) => Words(
    word: json["word"],
    definitions: List<Definition>.from(json["definitions"].map((x) => Definition.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "word": word,
    "definitions": List<dynamic>.from(definitions.map((x) => x.toJson())),
  };
}

class Definition {
  Definition({
    this.definition,
    this.partOfSpeech,
  });

  String definition;
  String partOfSpeech;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
    definition: json["definition"],
    partOfSpeech: json["partOfSpeech"],
  );

  Map<String, dynamic> toJson() => {
    "definition": definition,
    "partOfSpeech": partOfSpeech,
  };
}