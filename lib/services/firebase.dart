import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference journals =
      FirebaseFirestore.instance.collection('journals');

  Future addJournal(String journal) {
    return journals.add({
      'journal': journal,
      'time_stamp': Timestamp.now(),
    });
  }

  Stream get getJournals {
    return journals.orderBy('time_stamp', descending: true).snapshots();
  }

  Future updateJournal(String docID, String newJournal) {
    return journals.doc(docID).update({
      'journal': newJournal,
      'time_stamp': Timestamp.now(),
    });
  }

  Future deleteJournal(String docID) {
    return journals.doc(docID).delete();
  }
}
