import 'package:words/model/word.dart';

import 'word_event.dart';

class AddWord extends WordEvent {
  Word newWord;

  AddWord(Word word) {
    newWord = word;
  }

}