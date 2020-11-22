class Journal {
  String documentId;
  String mood;
  String date;
  String uid;
  String note;
  Journal({this.documentId, this.mood, this.date, this.note, this.uid});
  factory Journal.fromDoc(dynamic doc) => Journal(
        documentId: doc.documentId,
        mood: doc["mood"],
        date: doc["date"],
        note: doc["note"],
        uid: doc["uid"],
      );
}
