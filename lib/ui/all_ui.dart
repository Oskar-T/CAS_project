import 'package:words/words_form.dart';
import 'package:flutter/material.dart';
import 'package:words/progress.dart';
import 'package:words/word_of_the_day.dart';
import 'package:words/words_list.dart';


class AllUi extends StatelessWidget {
  const AllUi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xF1F1F1FF),
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
              padding: const EdgeInsets.all(8.0),
              child: WordList(),
            )
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
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => WordForm(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end);
        var curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
  );
}