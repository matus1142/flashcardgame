import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/Flashcards.dart';
import '../providers/FlashcardProvider.dart';
import 'dart:convert';
import 'dart:io';

Future<String?> AddVocabDialog(BuildContext context, String deck2dict) {
  TextEditingController DictFieldController = TextEditingController();
  TextEditingController MeanFieldController = TextEditingController();
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Vocab'),
          content: Container(
            height: 100,
            width: 10,
            child: SingleChildScrollView(
              //ป้องกัน button overflow
              child: Column(
                children: [
                  TextField(
                    //Add Vocab
                    onChanged: (value) {},
                    controller: DictFieldController,
                    decoration: InputDecoration(hintText: "Dict"),
                  ),
                  TextField(
                    //Add meaning
                    onChanged: (value) {},
                    controller: MeanFieldController,
                    decoration: InputDecoration(hintText: "Mean"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              child: Text("OK"),
              onPressed: () {
                var dictText = DictFieldController.value.text;
                var meanText = MeanFieldController.text;
                Flashcards vocablist = Flashcards(
                    deck: deck2dict,
                    dict: dictText,
                    mean: meanText,
                    weight: 1,
                    date: DateTime.now());
                var provider =
                    Provider.of<FlashcardProvider>(context, listen: false);
                if ((dictText != "") && (meanText != "")) {
                  //Check emptry
                  provider.addflashcardlists(vocablist);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

Future<void> EditVocabDialog(
    BuildContext context, String deck2dict, Flashcards oldVocab) {
  TextEditingController DictFieldController = TextEditingController();
  TextEditingController MeanFieldController = TextEditingController();
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Vocab'),
          content: Container(
            height: 100,
            width: 10,
            child: SingleChildScrollView(
              //ป้องกัน button overflow
              child: Column(
                children: [
                  TextField(
                    //Add Vocab
                    onChanged: (value) {},
                    controller: DictFieldController,
                    decoration: InputDecoration(hintText: "Dict"),
                  ),
                  TextField(
                    //Add meaning
                    onChanged: (value) {},
                    controller: MeanFieldController,
                    decoration: InputDecoration(hintText: "Mean"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              child: Text("OK"),
              onPressed: () {
                var dictText = DictFieldController.value.text;
                var meanText = MeanFieldController.text;
                Flashcards vocablist = Flashcards(
                    deck: deck2dict,
                    dict: dictText,
                    mean: meanText,
                    weight: oldVocab.weight,
                    date: DateTime.now());
                var provider =
                    Provider.of<FlashcardProvider>(context, listen: false);
                if ((dictText != "") && (meanText != "")) {
                  //Check emptry
                  provider.Editflashcardlists(oldVocab, vocablist);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

Future<List> pickFile() async {
  List _data = [];
  String? filePath;
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  // if no file is picked
  if (result == null) {
    return _data;
  } else {
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.first.path!;

    final input = File(filePath).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    _data = fields;
    return _data;
  }
}

Future<String?> AddDeckDialog(BuildContext context) {
  TextEditingController DeckFieldController = TextEditingController();
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Deck'),
          content: Container(
            height: 60,
            width: 10,
            child: SingleChildScrollView(
              //ป้องกัน button overflow
              child: Column(
                children: [
                  TextField(
                    //Add Vocab
                    onChanged: (value) {},
                    controller: DeckFieldController,
                    decoration: InputDecoration(hintText: "Deck"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              child: Text("OK"),
              onPressed: () {
                var DeckText = DeckFieldController.value.text;

                Deckcards decklist =
                    Deckcards(deck: DeckText, date: DateTime.now());
                var provider =
                    Provider.of<FlashcardProvider>(context, listen: false);
                if (DeckText != "") {
                  //Check emptry
                  provider.addDeckcardlists(decklist);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}

Future<void> EditDeckDialog(BuildContext context, Deckcards oldDeck) {
  TextEditingController DeckFieldController = TextEditingController();
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Deck'),
          content: Container(
            height: 60,
            width: 10,
            child: SingleChildScrollView(
              //ป้องกัน button overflow
              child: Column(
                children: [
                  TextField(
                    //Add Vocab
                    onChanged: (value) {},
                    controller: DeckFieldController,
                    decoration: InputDecoration(hintText: "Deck"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.red),
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green),
              child: Text("OK"),
              onPressed: () async {
                var deckText = DeckFieldController.value.text;
                Deckcards decklist =
                    Deckcards(deck: deckText, date: DateTime.now());
                var provider =
                    Provider.of<FlashcardProvider>(context, listen: false);
                if (deckText != "") {
                  //Check emptry
                  // Navigator.pop(context);
                  showDialog(
                      // The user CANNOT close this dialog  by pressing outsite it
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return Dialog(
                          // The background color
                          backgroundColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                // The loading indicator
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 15,
                                ),
                                // Some text
                                Text('Loading...')
                              ],
                            ),
                          ),
                        );
                      });
                  await provider.Editdeckcardlists(oldDeck, decklist).then((value) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                  
                }
              },
            )
          ],
        );
      });
}

Future<void> DeleteAllVocabDialog(BuildContext context, String deck) {
  return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Center(child: Text('Delete All Vocabulary')),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.red),
                child: Text("CANCEL"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green),
                child: Text("OK"),
                onPressed: () async {
                  var provider =
                      Provider.of<FlashcardProvider>(context, listen: false);
                  await provider.delAllflashcardlists(deck).then((value) {
                    Navigator.pop(context);
                  });
                  Fluttertoast.showToast(
                      msg: "Delete All Complete", gravity: ToastGravity.CENTER);
                },
              )
            ],
            actionsAlignment: MainAxisAlignment.center);
      });
}

Future<void> ImportCSVData(BuildContext context) async {
  List CSVdata = await pickFile();
  var provider = Provider.of<FlashcardProvider>(context, listen: false);

  for (int i = 1; i < CSVdata.length; i++) {
    Flashcards vocablist = Flashcards(
        deck: CSVdata[i][0],
        dict: CSVdata[i][1],
        mean: CSVdata[i][2],
        weight: CSVdata[i][3],
        date: DateTime.now());
    if ((CSVdata[i][0] != "") && (CSVdata[i][1] != "")) {
      //Check emptry
      await provider.addflashcardlists(vocablist);
    }
  }
}
