import 'package:flashcardgame/database/flashcard_db.dart';
import 'package:flashcardgame/models/Flashcards.dart';
import 'package:flutter/foundation.dart';

class FlashcardProvider with ChangeNotifier {
  //change notifier แจ้งเตือนเมื่อมีการเปลี่ยนแปลงข้อมูล
  List<Flashcards> flashcardlists = [];

  List<Flashcards> getflashcardlists() {
    return flashcardlists;
  }

  void initVocabData(String deck) async {
    var vocabdb = await FlashVocabDB(VocabdbName: "vocablist.db");

    List<Flashcards> allDataList = [];
    allDataList = await vocabdb.loadAllData();
    flashcardlists = [];
    Flashcards vocablist;
    for (vocablist in allDataList) {
      if (vocablist.deck == deck) {
        flashcardlists.add(Flashcards(
            deck: vocablist.deck,
            dict: vocablist.dict,
            mean: vocablist.mean,
            weight: vocablist.weight,
            date: DateTime.parse(vocablist.date.toString())));
      }
    }
    notifyListeners();
  }

  void addflashcardlists(Flashcards vocablist) async {
    var vocabdb = await FlashVocabDB(VocabdbName: "vocablist.db");
    //↑ /data/user/0/com.example.flashcardgame/app_flutter/vocablist.db
    await vocabdb.InsertData(vocablist);
    initVocabData(vocablist.deck);
    // flashcardlists = await vocabdb.loadAllData();
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
    Deckcards(
      deck: "JPN/TH",
      date: DateTime.now(),
    ),
    Deckcards(
      deck: "EN/TH",
      date: DateTime.now(),
    ),
  ];

  addDeckcardlists(Deckcards decklist) async {
    deckcardlists.add(decklist);
    var deckdb = await FlashDeckDB(DeckdbName: "decklist.db")
        .openDatabase(); //path: /data/user/0/com.example.flashcardgame/app_flutter/decklist.db
    print(deckdb);
    notifyListeners();
  }

  Future delDeckcardlists(int index) async {
    deckcardlists.removeAt(index);
    notifyListeners();
  }

  Future Editdeckcardlists(Deckcards decklist, int index) async {
    deckcardlists[index] = Deckcards(deck: decklist.deck, date: decklist.date);
    notifyListeners();
  }
}
