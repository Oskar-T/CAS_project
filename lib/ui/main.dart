import 'package:words/words_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:words/bloc/word_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordBloc>(
      create: (context) => WordBloc(),
      child: MaterialApp(
        theme: ThemeData(
            canvasColor: Color(0xFFECF1F9),
            primaryColor: Color(0xFF7D7CD4)
        ),
        home: AnimatedSplashScreen(
          splash: Container(
            child: Center(
              child: Text(""),
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                colors: [Color(0xFF7777C0), Color(0xFF8A7CD4)])
            ),
          ),
          splashTransition: SplashTransition.scaleTransition,
          duration: 3,
          nextScreen: WordList(),
        ),
      ),
    );
  }
}
