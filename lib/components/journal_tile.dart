import 'package:flutter/material.dart';
import 'package:journal/pages/tilepage.dart';

class JournalTile extends StatelessWidget {
  final String data;
  final Function() onDelete;
  final Function() onPressed;
  final String docID;
  const JournalTile({
    super.key,
    required this.data,
    required this.onPressed,
    required this.onDelete,
    required this.docID,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 7, left: 10, right: 10, bottom: 7),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 100,
          width: 100,
          child: ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 172, 13, 13),
            ),
            tileColor: Colors.white,
            contentPadding:
                EdgeInsets.only(top: 7, left: 10, right: 20, bottom: 20),
            title: Text(data),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TilePage(
                      onDelete: onDelete,
                      content: data,
                      docID: docID,
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
