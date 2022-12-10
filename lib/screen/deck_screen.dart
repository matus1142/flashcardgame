import 'package:flashcardgame/lib/Library.dart';
import 'package:flashcardgame/models/Flashcards.dart';
import 'package:flashcardgame/screen/dict_screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/FlashcardProvider.dart';

class DeckScreen extends StatefulWidget {
  final String deck2dict ='';

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<FlashcardProvider>(context, listen: false).initDeckData();
    // Provider.of<FlashcardProvider>(context,listen: false).initVocabData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deck"),
      ),
      body: Consumer(builder:
          (BuildContext context, FlashcardProvider provider, Widget? child) {
        var provider = Provider.of<FlashcardProvider>(context, listen: false);
        var count = provider.deckcardlists.length;
        return ListView.builder(
            itemCount: count,
            itemBuilder: (context, int index) {
              Deckcards deckcards = provider.deckcardlists[index];
              return Card(
                elevation: 3, //เงาระหว่าง card
                margin: const EdgeInsets.symmetric(
                    vertical: 3, horizontal: 15), //ระยะหว่าง card
                child: Column(
                  children: [
                    ListTile(
                      title: Text(deckcards.deck),
                      trailing:PopupMenuButton(itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: Text("Edit"),
                              value: 'Edit',
                            ),
                            PopupMenuItem(
                              child: Text("Delete"),
                              value: 'Delete',
                            )
                          ];
                        }, onSelected: (String value) async {
                          if (value == 'Edit') {
                            await EditDeckDialog(context, index);
                            //provider.Editflashcardlists(index);
                          } else if (value == 'Delete') {
                            await provider.delDeckcardlists(deckcards);
                          }
                        }),
                      onTap: () {
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: ((context) {
                        return DictScreen(deck2dict:deckcards.deck);
                      })),
                    );
                      },
                    )
                  ],
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          final text = await AddDeckDialog(context);
          print("Add deck");
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
