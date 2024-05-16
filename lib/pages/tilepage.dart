import 'package:flutter/material.dart';
import 'package:journal/services/firebase.dart';

class TilePage extends StatefulWidget {
  final String content;
  final Function() onDelete;
  final String docID;

  const TilePage({
    super.key,
    required this.content,
    required this.onDelete,
    required this.docID,
  });

  @override
  State<TilePage> createState() => _TilePageState();
}

class _TilePageState extends State<TilePage> {
  late final TextEditingController textEditingController;
  var editing = false;
  final FirestoreService journal = FirestoreService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController(text: widget.content);
  }

  void onUpdate(String docID, String newJournal) {
    journal.updateJournal(docID, newJournal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dear Nikki'),
      ),
      body: StreamBuilder(
          stream: journal.journals.doc(widget.docID).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  color: const Color.fromARGB(255, 241, 196, 196),
                  width: 800,
                  height: 800,
                  child: GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        editing = !editing;
                      });
                    },
                    child: editing
                        ? TextFormField(
                            controller: textEditingController,
                            maxLines: 200,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.deepPurple,
                                ),
                                onPressed: () {
                                  onUpdate(
                                      widget.docID, textEditingController.text);
                                  setState(() {
                                    editing = !editing;
                                  });
                                },
                              ),
                            ),
                          )
                        : Text(
                            '${snapshot.data!['journal']}',
                            style: TextStyle(fontSize: 20),
                          ),
                  ),
                ),
              );
            } else {
              return Text('LOADING DATA');
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onDelete,
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
