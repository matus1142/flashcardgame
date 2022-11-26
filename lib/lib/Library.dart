import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/Flashcards.dart';
import '../providers/FlashcardProvider.dart';

Future<String?> displayTextInputDialog(BuildContext context) {
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
            child: SingleChildScrollView( //ป้องกัน button overflow
              child: Column(
                children: [
                  TextField( //Add Vocab
                    onChanged: (value) {},
                    controller: DictFieldController,
                    decoration: InputDecoration(hintText: "Dict"),
                  ),
                  TextField(//Add meaning
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
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green),
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
                if ((dictText != "") && (meanText != "")) {//Check emptry
                  provider.addflashcardlists(vocablist);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}


Future<void> EditVocabDialog(BuildContext context,int index) {
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
            child: SingleChildScrollView( //ป้องกัน button overflow
              child: Column(
                children: [
                  TextField( //Add Vocab
                    onChanged: (value) {},
                    controller: DictFieldController,
                    decoration: InputDecoration(hintText: "Dict"),
                  ),
                  TextField(//Add meaning
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
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green),
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
                if ((dictText != "") && (meanText != "")) {//Check emptry
                  provider.Editflashcardlists(vocablist,index);
                }
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}