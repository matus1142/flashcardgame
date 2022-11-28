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

  Future delflashcardlists(int index) async {
    flashcardlists.removeAt(index);
    notifyListeners();
  }

  Future Editflashcardlists(Flashcards vocablist, int index) async {
    flashcardlists[index] = Flashcards(
        deck: vocablist.deck,
        dict: vocablist.dict,
        mean: vocablist.mean,
        weight: vocablist.weight,
        date: vocablist.date);
    notifyListeners();
  }

  List<Deckcards> deckcardlists = [
    Deckcards(deck: "JPN/TH", date: DateTime.now()),
  ];

  addDeckcardlists(Deckcards decklist) {
    deckcardlists.add(decklist);

    notifyListeners();
  }

  Future delDeckcardlists(int index) async {
    deckcardlists.removeAt(index);
    notifyListeners();
  }

    Future Editdeckcardlists(Deckcards decklist, int index) async {
    deckcardlists[index] = Deckcards(
        deck: decklist.deck,
        date: decklist.date);
    notifyListeners();
  }

}
