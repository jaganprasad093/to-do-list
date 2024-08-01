import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do/core/constants/image_constants.dart';
import 'package:to_do/model/model.dart';

class HomepageController with ChangeNotifier {
  static late Box myBox;
  static Future<void> initialize() async {
    myBox = await Hive.openBox('MyBox');
  }

  static List notelistKeys = [];
  List imageList = [
    ImageConstants.event,
    ImageConstants.goal,
    ImageConstants.task,
  ];

  Future<void> addNote(
      {required String title,
      required String date,
      required String time,
      required String reason,
      int imageIndex = 0}) async {
    await myBox.add({
      "title": title,
      "date": date,
      "time": time,
      "reason": reason,
      "imageIndex": imageIndex
    });
    notelistKeys = myBox.keys.toList();
    notifyListeners();
  }

  Future<void> deleteList(var key) async {
    await myBox.deleteAll(key);
    notelistKeys = myBox.keys.toList();
    notifyListeners();
  }

  getinikey() {
    notelistKeys = myBox.keys.toList();
  }
}
