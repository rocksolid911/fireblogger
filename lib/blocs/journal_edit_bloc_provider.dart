import 'package:flutter/material.dart';
import 'journal_edit_bloc.dart';

class JournalEditBlocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;
  const JournalEditBlocProvider({Key key, Widget child, this.journalEditBloc})
      : super(key: key, child: child);
  static JournalEditBlocProvider of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(
        aspect: JournalEditBlocProvider) as JournalEditBlocProvider);
  }

  @override
  bool updateShouldNotify(JournalEditBlocProvider old) => false;
}
