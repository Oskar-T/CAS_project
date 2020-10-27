import 'package:words/db/database_provider.dart';
import 'package:words/events/delete_word.dart';
import 'package:words/events/set_words.dart';
import 'package:words/words_form.dart';
import 'package:words/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_definition.dart';
import 'bloc/word_bloc.dart';
import 'dart:convert';
import 'word_of_the_day.dart';
import 'progress.dart';
import 'request_examples.dart';

class WordList extends StatefulWidget {
  const WordList({Key key}) : super(key: key);

  @override
  _WordListState createState() => _WordListState();
}

class _WordListState extends State<WordList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getWords().then(
          (wordList) {
        BlocProvider.of<WordBloc>(context).add(SetWords(wordList));
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    print("Building entire word list scaffold");
    return Scaffold(
      backgroundColor: Color(0xFFECF1F9),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Center(
                child: Progress(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: WordOfTheDay(),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.7,
              child: BlocConsumer<WordBloc, List<Word>>(
                builder: (context, wordList) {
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {

                      Word word = wordList[index];
                      return Dismissible(
                        background: Container(
                          color: Colors.redAccent,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.delete_forever,
                                  size: 50.0,
                                  color: Colors.white,
                                ),
                              ]),
                        ),
                        direction: DismissDirection.startToEnd,
                        key: UniqueKey(),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: ExpansionTile(
                            title: FutureBuilder(
                                future: Future.wait([fetchDefinition(word.name)]),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData) {
                                    Words words =
                                    Words.fromJson(jsonDecode(snapshot.data[0]));
                                    return Container(
                                      child: Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              child: Text(
                                                (words.word + ":"),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF7D7CD4)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width *
                                                  0.4,
                                              child: Text(
                                                words.definitions[0].definition,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return Center(child: CircularProgressIndicator());
                                }
                            ),
                            children: <Widget>[
                              Divider(
                                color: Color(0xFF707070),
                                height: 0.5,
                                indent: 20,
                                endIndent: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 15.0, left: 25.0, right: 25.0
                                ),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Example:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF7D7CD4),
                                        fontSize: 15.0),
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                  future: Future.wait([fetchExamples(word.name)]),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      Example example =
                                      Example.fromJson(jsonDecode(snapshot.data[0]));

                                      if (example.examples.length == 0) {
                                        example.examples.add("No examples for this word");
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, bottom: 25.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            example.examples[0],
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 25.0, right: 25.0, bottom: 25.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: Text(
                                            "${snapshot.error}",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      );
                                    }
                                    return CircularProgressIndicator();
                                  })
                            ],
                          ),
                        ),
                        onDismissed: (direction) {
                          DatabaseProvider.db.delete(word.id).then((_) {
                            BlocProvider.of<WordBloc>(context).add(
                              DeleteWord(index),
                            );
                          });
                        },
                      );
                    },
                    itemCount: wordList.length,
                  );
                },
                listener: (BuildContext context, wordList) {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.height * 0.18,
        child: FittedBox(
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            backgroundColor: Color(0xFF7D7CD4),
            child: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => WordForm()),
            ),
          ),
        ),
      ),
    );
  }
}
