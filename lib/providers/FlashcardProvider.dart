import 'package:flashcardgame/models/Flashcards.dart';
import 'package:flutter/foundation.dart';

class FlashcardProvider with ChangeNotifier {
  //change notifier แจ้งเตือนเมื่อมีการเปลี่ยนแปลงข้อมูล

  List<Flashcards> flashcardlists = [
    Flashcards(
        deck: "JPN/TH",
        dict: "日本",
        mean: "ญี่ปุ่น",
        weight: 1,
        date: DateTime.now()),
    Flashcards(
        deck: "JPN/TH",
        dict: "服",
        mean: "เสื้อผ้า",
        weight: 1,
        date: DateTime.now()),
  ];

  List<Flashcards> getflashcardlists() {
    return flashcardlists;
  }

  addflashcardlists(Flashcards vocablist) {
    flashcardlists.add(vocablist);

    notifyListeners();
  }
}
