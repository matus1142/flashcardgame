import 'package:flashcardgame/database/flashcard_db.dart';
import 'package:flashcardgame/models/Flashcards.dart';
import 'package:flutter/foundation.dart';

class FlashcardProvider with ChangeNotifier {
  //change notifier แจ้งเตือนเมื่อมีการเปลี่ยนแปลงข้อมูล
  List<Flashcards> flashcardlists = [];

  List<Flashcards> getflashcardlists() {
    return flashcardlists;
  }

  Future<void> initVocabData(String deck) async {
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

  Future<void> addflashcardlists(Flashcards vocablist) async {
    var vocabdb = await FlashVocabDB(VocabdbName: "vocablist.db");
    //↑ /data/user/0/com.example.flashcardgame/app_flutter/vocablist.db
    await vocabdb.InsertData(vocablist);
    await initVocabData(vocablist.deck);
    // flashcardlists = await vocabdb.loadAllData();
    notifyListeners();
  }

  Future delflashcardlists(Flashcards vocablist) async {
    var vocabdb = await FlashVocabDB(VocabdbName: "vocablist.db");
    await vocabdb.DeleteData(vocablist);
    await initVocabData(vocablist.deck);
    notifyListeners();
  }

  Future delAllflashcardlists(String deck) async {
    var vocabdb = await FlashVocabDB(VocabdbName: "vocablist.db");
    await vocabdb.DeleteAllData(deck);
    await initVocabData(deck);
    notifyListeners();
  }

  Future Editflashcardlists(Flashcards oldVocab, Flashcards newVocab) async {
    var vocabdb = await FlashVocabDB(VocabdbName: "vocablist.db");
    await vocabdb.EditData(oldVocab, newVocab);
    await initVocabData(newVocab.deck);
    notifyListeners();
  }

  List<Deckcards> deckcardlists = [];

  void initDeckData() async {
    var deckdb = await FlashDeckDB(DeckdbName: "decklist.db");
    deckcardlists = await deckdb.loadAllData();
    notifyListeners();
  }

  Future addDeckcardlists(Deckcards decklist) async {
    var deckdb = await FlashDeckDB(DeckdbName: "decklist.db");
     //path: /data/user/0/com.example.flashcardgame/app_flutter/decklist.db
    await deckdb.InsertData(decklist);
    deckcardlists = await deckdb.loadAllData();
    notifyListeners();
  }

  Future delDeckcardlists(Deckcards decklist) async {
    var deckdb = await FlashDeckDB(DeckdbName: "decklist.db");
    await deckdb.DeleteData(decklist);
    deckcardlists = await deckdb.loadAllData();
    notifyListeners();
  }


  Future Editdeckcardlists(Deckcards oldDeck, Deckcards newDeck) async {
    var deckdb = await FlashDeckDB(DeckdbName: "decklist.db");
    await deckdb.EditData(oldDeck,newDeck);
    deckcardlists = await deckdb.loadAllData();
    notifyListeners();
  }

}
