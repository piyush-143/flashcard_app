import 'package:flashcard_app/database/local_database/db_helper.dart';
import 'package:flashcard_app/view_model/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';
import 'package:provider/provider.dart';

class CustomFlashCard extends StatelessWidget {
  final int index;
  const CustomFlashCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return FlashCard(
      width: 310,
      height: 350,
      //controller: cardController,
      duration: const Duration(milliseconds: 500),
      frontWidget: () => _customContainer(isQue: false),
      backWidget: () => _customContainer(isQue: true),
    );
  }

  Widget _customContainer({required isQue}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: Colors.black, width: 1.5)),
      child: Center(
        child: Consumer<DBProvider>(
          builder: (BuildContext ctx, DBProvider value, Widget? child) =>
              Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              isQue
                  ? "Question:\n${value.allData()[index][DBHelper.columnQuestion]}?"
                  : "Answer:\n${value.allData()[index][DBHelper.columnAnswer]}.",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 0.4,
                  height: 1.2,
                  fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
