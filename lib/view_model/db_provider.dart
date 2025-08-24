import 'package:flutter/material.dart';

import '../database/local_database/db_helper.dart';

class DBProvider with ChangeNotifier {
  final DBHelper _dbRef = DBHelper.getInstance;

  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> get allData => _allData;

  Future<void> getInitialData() async {
    //await Future.delayed(const Duration(milliseconds: 10));
    _allData = await _dbRef.getAllData();
    notifyListeners();
  }

  Future<void> addData({required String ques, required String ans}) async {
    bool check = await _dbRef.addFlashCard(ques: ques, ans: ans);
    if (check) {
      _allData = await _dbRef.getAllData();
      notifyListeners();
    }
  }

  Future<void> updateData(
      {required String ques, required String ans, required int sno}) async {
    bool check = await _dbRef.updateFlashCard(ques: ques, ans: ans, sno: sno);
    if (check) {
      _allData = await _dbRef.getAllData();
      notifyListeners();
    }
  }

  Future<void> deleteData({required int sno}) async {
    bool check = await _dbRef.deleteFlashCard(sno: sno);
    if (check) {
      _allData = await _dbRef.getAllData();
      notifyListeners();
    }
  }
}
