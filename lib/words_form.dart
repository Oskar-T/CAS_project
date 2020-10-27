import 'package:words/bloc/word_bloc.dart';
import 'package:words/db/database_provider.dart';
import 'package:words/events/add_word.dart';
import 'package:words/model/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordForm extends StatefulWidget {
  final Word word;
  final int wordIndex;

  WordForm({this.word, this.wordIndex});

  @override
  State<StatefulWidget> createState() {
    return WordFormState();
  }
}

class WordFormState extends State<WordForm> {
  String _name;


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: InputDecoration(labelText: 'Insert your word here'),
      maxLength: 20,
      style: TextStyle(fontSize: 28),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Word is Required!';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }


  @override
  void initState() {
    super.initState();
    if (widget.word != null) {
      _name = widget.word.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildName(),
              SizedBox(height: 40),
              RaisedButton(
                color: Color(0xFF7D7CD4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();

                  Word word = Word(
                    name: _name,
                  );

                  DatabaseProvider.db.insert(word).then(
                        (storedWord) => BlocProvider.of<WordBloc>(context).add(
                      AddWord(storedWord),
                    ),
                  );

                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}