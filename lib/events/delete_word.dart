import 'word_event.dart';

class DeleteWord extends WordEvent {
  int wordIndex;

  DeleteWord(int index) {
    wordIndex = index;
  }

}