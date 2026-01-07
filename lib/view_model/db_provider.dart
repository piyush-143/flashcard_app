import 'package:flutter/material.dart';

import '../database/local_database/db_helper.dart';

class DBProvider with ChangeNotifier {
  final DBHelper _dbRef = DBHelper.getInstance;

  List<Map<String, dynamic>> _allData = [];
  List<Map<String, dynamic>> get allData => _allData;

  Future<void> getInitialData() async {
    try {
      _allData = await _dbRef.getAllData();
      notifyListeners();
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }

  Future<void> addData({required String ques, required String ans}) async {
    try {
      bool check = await _dbRef.addFlashCard(ques: ques, ans: ans);
      if (check) {
        await getInitialData();
      }
    } catch (e) {
      debugPrint("Error adding data: $e");
    }
  }

  Future<void> updateData(
      {required String ques, required String ans, required int sno}) async {
    try {
      bool check = await _dbRef.updateFlashCard(ques: ques, ans: ans, sno: sno);
      if (check) {
        await getInitialData();
      }
    } catch (e) {
      debugPrint("Error updating data: $e");
    }
  }

  Future<void> deleteData({required int sno}) async {
    try {
      bool check = await _dbRef.deleteFlashCard(sno: sno);
      if (check) {
        await getInitialData();
      }
    } catch (e) {
      debugPrint("Error deleting data: $e");
    }
  }
}
