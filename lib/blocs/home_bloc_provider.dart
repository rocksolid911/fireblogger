import 'dart:async';
import 'package:flutter/material.dart';
import 'home_bloc.dart';
class HomeBlocProvider extends InheritedWidget{
  final HomeBloc homeBloc;
  final String uid;

 const HomeBlocProvider({Key key,Widget child,this.homeBloc,this.uid}):super(key:key,child: child);

 static HomeBlocProvider of (BuildContext context){
   return (context.dependOnInheritedWidgetOfExactType(aspect: HomeBlocProvider) as HomeBlocProvider);
 }

  @override
  bool updateShouldNotify(HomeBlocProvider old) {
   return homeBloc!= old.homeBloc;
  }

}