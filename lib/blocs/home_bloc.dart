import 'dart:async';
import 'package:flutter/material.dart';
import '../services/db_firestore_api.dart';
import '../services/auth_api.dart';
import '../models/journal.dart';
class HomeBloc{
  final DbApi dbApi;
  final Authapi authapi;
  final StreamController<List<Journal>> _journalController = StreamController<List<Journal>>.broadcast();

  HomeBloc(this.dbApi, this.authapi){
    _startListeners();
  }
  Sink <List<Journal>> get _addListJournal => _journalController.sink;
  Stream <List<Journal>> get _listJournal => _journalController.stream;

  final StreamController<Journal> _journalDeleteController = StreamController<Journal>.broadcast();
  Sink <Journal> get _deleteJournal => _journalDeleteController.sink;

  void dispose(){
    _journalController.close();
    _journalDeleteController.close();
  }

  void _startListeners() {
    authapi.getFirebaseAuth().currentUser().then((user){
      dbApi.getJournalList(user.uid).listen((journalDocs) {
        _addListJournal.add(journalDocs);
      });
    });
  }

}