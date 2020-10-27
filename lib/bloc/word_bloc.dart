import 'package:words/events/add_word.dart';
import 'package:words/events/delete_word.dart';
import 'package:words/events/word_event.dart';
import 'package:words/events/set_words.dart';
import 'package:words/model/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordBloc extends Bloc<WordEvent, List<Word>> {
  @override
  List<Word> get initialState => List<Word>();

  @override
  Stream<List<Word>> mapEventToState(WordEvent event) async* {
    if(event is SetWords) {
      yield event.wordList;
    } else if(event is AddWord) {
      List<Word> newState = List.from(state);
      if(event.newWord != null) {
        newState.add(event.newWord);
      }
      yield newState;
    } else if (event is DeleteWord) {
      List<Word> newState = List.from(state);
      newState.removeAt(event.wordIndex);
      yield newState;
    }

  }

}