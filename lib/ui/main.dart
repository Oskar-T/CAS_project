import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:words/bloc/word_bloc.dart';
import 'all_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordBloc>(
      create: (context) => WordBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            canvasColor: Color(0xFFECF1F9),
            primaryColor: Color(0xFF7D7CD4)
        ),
        home: AnimatedSplashScreen(
          backgroundColor: Color(0xFF7777C0),
          splash: Container(
            child: Center(
              child: Text("Wordify", style: TextStyle(
                fontSize: 40.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),),
            ),
          ),
          splashTransition: SplashTransition.fadeTransition,
          duration: 1,
          nextScreen: AllUi(),
        ),
      ),
    );
  }
}
