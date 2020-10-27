import 'package:words/model/word.dart';

import 'word_event.dart';

class SetWords extends WordEvent {
  List<Word> wordList;

  SetWords(List<Word> words) {
    wordList = words;
  }

}