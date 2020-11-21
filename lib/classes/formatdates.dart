import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class FormatDate{
  String dateFormatShortMonthDayYear(String date){
    return DateFormat.yMMMd().format(DateTime.parse(date));
  }
  String dateFormatDayNo(String date){
    return DateFormat.d().format(DateTime.parse(date));
  }
  String dateFormatShortDayNAme(String date){
    return DateFormat.E().format(DateTime.parse(date));
  }
}