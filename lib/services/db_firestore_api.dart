import '../models/journal.dart';
abstract class DbApi{
  Stream <List<Journal>> getJournalList(String uid);
 // Future<Journal> getJournal(String documentId);
  Future<bool> addJournal(Journal journal);
  void updateJournal(Journal journal);
  void updateJournalWithTran(Journal journal);
  void deleteJournal(Journal journal);
}