import '../database/local_database/db_helper.dart';
import 'package:flutter/material.dart';

class DBProvider with ChangeNotifier {
  DBHelper dbRef = DBHelper.getInstance;
  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> allData() => _allData;

  void getInitialData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    _allData = await dbRef.getAllData();
    notifyListeners();
  }

  void addData({required String ques, required String ans}) async {
    bool check = await dbRef.addFlashCard(ques: ques, ans: ans);
    if (check) {
      _allData = await dbRef.getAllData();
      notifyListeners();
    }
  }

  void updateData(
      {required String ques, required String ans, required int sno}) async {
    bool check = await dbRef.updateFlashCard(ques: ques, ans: ans, sno: sno);
    if (check) {
      _allData = await dbRef.getAllData();
      notifyListeners();
    }
  }

  void deleteData({required int sno}) async {
    bool check = await dbRef.deleteFlashCard(sno: sno);
    if (check) {
      _allData = await dbRef.getAllData();
      notifyListeners();
    }
  }
}
