import 'package:flutter/material.dart';

class MoodIcon {
  final String title;
  final double rotation;
  final Color color;
  final IconData iconData;
 const MoodIcon({this.color, this.title, this.iconData, this.rotation});
 IconData getMoodIcon(String mood){
   return _moodIcon[_moodIcon.indexWhere((icon) => icon.title==mood)].iconData;
 }
 Color getMoodColor(String mood){
   return _moodIcon[_moodIcon.indexWhere((element) => element.title==mood)].color;
 }
  double getMoodRotation(String mood){
    return _moodIcon[_moodIcon.indexWhere((element) => element.title==mood)].rotation;
  }
  List<MoodIcon> getMoodIconList(){
   return _moodIcon;
  }
}

 const List<MoodIcon> _moodIcon = const <MoodIcon>[
  const MoodIcon(
      title: 'very satisfied',
      color: Colors.amber,
      iconData: Icons.sentiment_very_satisfied,
      rotation: 0.4),
   const MoodIcon(
      color: Colors.red,
      title: 'satisfied',
      iconData: Icons.sentiment_satisfied,
      rotation: 0.2),
  const MoodIcon(
       title: 'neutarl',
       color: Colors.blue,
       iconData: Icons.sentiment_neutral,
       rotation: 0.4),
   const MoodIcon(
       title: 'dissatisfied',
       color: Colors.deepOrange,
       iconData: Icons.sentiment_dissatisfied,
       rotation: 0.4),
  const MoodIcon(
       title: 'very dissatisfied',
       color: Colors.deepOrangeAccent,
       iconData: Icons.sentiment_very_dissatisfied,
       rotation: 0.4),
];
