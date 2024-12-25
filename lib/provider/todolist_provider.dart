import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodolistProvider extends ChangeNotifier{
  final List<Map<String, dynamic>> _todolist = [
    {"name" : "Grocery", "Time" : DateTime.now(), "ischeck" : false}
  ];

  List<Map<String, dynamic>> get getAllItems => _todolist;

  void addItem(String item){
    _todolist.add({
      "name" : item,
      "Time" : DateTime.now(),
      "ischeck" : false
    });
    notifyListeners();
  }

  void removeItem(int index){
    _todolist.removeAt(index);
    notifyListeners();
  }

  void updateCheckbox(int index, bool isChecked) {
    _todolist[index]['ischeck'] = isChecked;
    notifyListeners();
  }

    String formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a')
        .format(dateTime); // Customize format as needed
  }
}