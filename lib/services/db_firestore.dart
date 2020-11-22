import 'package:cloud_firestore/cloud_firestore.dart';
import 'db_firestore_api.dart';
import '../models/journal.dart';

class DbFirestore implements DbApi {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String _collectionJournal = 'Journal';
  DbFirestoreService() {
    _firebaseFirestore.settings;
  }

  Future<bool> addJournal(Journal journal) async {
    DocumentReference _documentReference =
        await _firebaseFirestore.collection(_collectionJournal).add({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
      'uid': journal.uid,
    });
    return _documentReference.id != null; //documentId depricated for id
  }

  void deleteJournal(Journal journal) async {
    await _firebaseFirestore
        .collection(_collectionJournal)
        .doc(journal.documentId)
        .delete()
        .catchError((error) => print('error:$error'));
  }
  //
  // Future<Journal> getJournal(String documentId) {
  //   // TODO: implement getJournal
  //   throw UnimplementedError();
  // }

  Stream<List<Journal>> getJournalList(String uid) {
    return _firebaseFirestore
        .collection(_collectionJournal)
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Journal> _journalDocs =
          snapshot.docs.map((doc) => Journal.fromDoc(doc)).toList();
      _journalDocs.sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
      return _journalDocs;
    });
  }

  void updateJournal(Journal journal) async {
    await _firebaseFirestore
        .collection(_collectionJournal)
        .doc(journal.documentId)
        .update({
      'date': journal.date,
      'mood': journal.mood,
      'note': journal.note,
    }).catchError((error) => print('error updating : $error'));
  }

  void updateJournalWithTran(Journal journal) {
    // TODO: implement updateJournalWithTran
  }
}
