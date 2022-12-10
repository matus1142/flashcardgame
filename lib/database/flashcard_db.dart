import 'dart:ffi';
import 'dart:io';

import 'package:flashcardgame/models/Flashcards.dart';
import 'package:flutter/rendering.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

///*************************************************** Vocab ******************************************************************///

class FlashVocabDB {
  String? VocabdbName;

  FlashVocabDB({this.VocabdbName});

  Future<Database> openDatabase() async {
    Directory appDirectory =
        await getApplicationDocumentsDirectory(); //find user account each phone for create database
    String dbLocation = join(appDirectory.path, VocabdbName);
    //create database
    DatabaseFactory dbFactory =
        await databaseFactoryIo; //declare strucure of database
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }

  //for save data
  Future<int> InsertData(Flashcards vocablist) async {
    //database => Store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("vocabulary");

    // save statement as json
    var keyID = store.add(db, {
      "deck": vocablist.deck,
      "dict": vocablist.dict,
      "mean": vocablist.mean,
      "weight": vocablist.weight,
      "date": vocablist.date.toIso8601String(), //standard date time format
    });
    db.close();
    return keyID; //เรียงลำดับจาก 1,2,3,4,...
  }

  //load data
  Future<List<Flashcards>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("vocabulary");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [
          SortOrder(Field.key, false)
        ]));
    List<Flashcards> Vocablist = List<Flashcards>.from(<List<Flashcards>>[]);
    var record;
    for (record in snapshot) {
      Vocablist.add(Flashcards(
          deck: record["deck"],
          dict: record["dict"],
          mean: record["mean"],
          weight: record["weight"],
          date: DateTime.parse(record["date"])));
    }
    return Vocablist;
  }

  Future DeleteData(Flashcards vocablist) async {
    //database => Store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("vocabulary");
    var findkey = await store.findKey(db,
        finder: Finder(
            filter: Filter.and([
          Filter.equals('deck', vocablist.deck),
          Filter.equals('dict', vocablist.dict),
          Filter.equals('mean', vocablist.mean),
          Filter.equals('date', vocablist.date.toIso8601String())
        ])));
    var record = await store.record(findkey!);
    await record.delete(db);
    // await store.delete(db);
    db.close();
  }

  Future DeleteAllData(String deck) async {
    //database => Store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("vocabulary");
    await store.delete(db, finder: Finder(filter: Filter.equals('deck', deck)));
    // await store.delete(db);
    db.close();
  }

  Future EditData(Flashcards oldVocab, Flashcards newVocab) async {
    //database => Store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("vocabulary");
    var findkey = await store.findKey(db,
        finder: Finder(
            filter: Filter.and([
          Filter.equals('deck', oldVocab.deck),
          Filter.equals('dict', oldVocab.dict),
          Filter.equals('mean', oldVocab.mean),
          Filter.equals('date', oldVocab.date.toIso8601String())
        ])));
    var record = await store.record(findkey!);
    await record.update(db, {
      'dict': newVocab.dict,
      'mean': newVocab.mean,
      'date': newVocab.date.toIso8601String()
    });
    // await store.delete(db);
    db.close();
  }
}

///*************************************************** Deck ******************************************************************///

class FlashDeckDB {
  String? DeckdbName;

  FlashDeckDB({this.DeckdbName});

  Future<Database> openDatabase() async {
    Directory appDirectory =
        await getApplicationDocumentsDirectory(); //find user account each phone for create database
    String dbLocation = join(appDirectory.path, DeckdbName);
    //create database
    DatabaseFactory dbFactory =
        await databaseFactoryIo; //declare strucure of database
    Database db = await dbFactory.openDatabase(dbLocation);

    return db;
  }



  Future<List<Deckcards>> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("deck");
    var snapshot = await store.find(db);
    List<Deckcards> Decklist = List<Deckcards>.from(<List<Deckcards>>[]);
    var record;
    for (record in snapshot) {
      Decklist.add(Deckcards(
          deck: record["deck"],
          date: DateTime.parse(record["date"])));
    }
    return Decklist;
  }

    Future<int> InsertData(Deckcards decklist) async {
    //database => Store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("deck");

    // save statement as json
    var keyID = store.add(db, {
      "deck": decklist.deck,
      "date": decklist.date.toIso8601String(), //standard date time format
    });
    db.close();
    return keyID; //เรียงลำดับจาก 1,2,3,4,...
  }

  Future DeleteData(Deckcards decklist) async {
    //database => Store
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("deck");
    var findkey = await store.findKey(db,
        finder: Finder(
            filter: Filter.and([
          Filter.equals('deck', decklist.deck),
          Filter.equals('date', decklist.date.toIso8601String())
        ])));
    var record = await store.record(findkey!);
    await record.delete(db);
    db.close();
  }

}
