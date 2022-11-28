import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Flashcards.dart';
import '../providers/FlashcardProvider.dart';
import 'dart:convert';
import 'dart:io';

Future<String?> AddVocabDialog(BuildContext context) {
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
                    deck: "JPN/TH",
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

Future<void> EditVocabDialog(BuildContext context, int index) {
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
                    deck: "JPN/TH",
                    dict: dictText,
                    mean: meanText,
                    weight: 1,
                    date: DateTime.now());
                var provider =
                    Provider.of<FlashcardProvider>(context, listen: false);
                if ((dictText != "") && (meanText != "")) {
                  //Check emptry
                  provider.Editflashcardlists(vocablist, index);
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

    final input = File(filePath!).openRead();
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

                Deckcards decklist = Deckcards(
                    deck: DeckText,
                    date: DateTime.now());
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

Future<void> EditDeckDialog(BuildContext context, int index) {
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
              onPressed: () {
                var deckText = DeckFieldController.value.text;
                Deckcards decklist = Deckcards(
                    deck: deckText,
                    date: DateTime.now());
                var provider =
                    Provider.of<FlashcardProvider>(context, listen: false);
                if (deckText != "") {
                  //Check emptry
                  provider.Editdeckcardlists(decklist, index);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}