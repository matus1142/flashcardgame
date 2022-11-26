import 'package:flashcardgame/providers/FlashcardProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/Flashcards.dart';
import 'package:flashcardgame/lib/Library.dart';

class DictScreen extends StatefulWidget {
  @override
  State<DictScreen> createState() => _DictScreenState();
}

class _DictScreenState extends State<DictScreen> {
  TextEditingController SearchFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dict"),
        actions: [
          IconButton(
              onPressed: (() async {
                Fluttertoast.showToast(
                    msg: "Upload", gravity: ToastGravity.CENTER);
                print("Upload");
              }),
              icon: Icon(Icons.keyboard_double_arrow_up_rounded)),
          IconButton(
              onPressed: (() async {
                final text = await displayTextInputDialog(context);
                //print(text);
              }),
              icon: Icon(Icons.add)),
        ],
      ),
      body: Consumer(
          //รับข้อมูลจาก Provider มาใช้ใน consumer
          builder: (BuildContext context, FlashcardProvider provider,
              Widget? child) {
        var count = provider.flashcardlists.length;
        return ListView.builder(
            itemCount:
                count + 1, //number card, offset 1 for Add Button Upload CSV
            itemBuilder: (context, int counter) {
              int index = 0;
              if (counter == 0) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  height: 30,
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: SearchFieldController,
                    decoration: InputDecoration(hintText: "Search"),
                    onChanged: (value){
                      print(value);

                      //Add search function here

                    },
                  ),
                );
              } else {
                index = counter - 1;
              }
              Flashcards data = provider.flashcardlists[index];

              return Card(
                elevation: 3, //เงาระหว่าง card
                margin: const EdgeInsets.symmetric(
                    vertical: 3, horizontal: 15), //ระยะหว่าง card
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text("${data.dict} - ${data.mean}"),
                          subtitle: Text("weight : ${data.weight}"),
                          trailing: PopupMenuButton(itemBuilder: (context) {
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
                              print("Edit ${data.dict}");
                              await EditVocabDialog(context, index);
                              //provider.Editflashcardlists(index);
                            } else if (value == 'Delete') {
                              print("Delete ${data.dict}");
                              await provider.delflashcardlists(index);
                            }
                          })),
                    ]),
              );
            });
      }),
    );
  }
}
