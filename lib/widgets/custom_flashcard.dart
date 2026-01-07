import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/local_database/db_helper.dart';
import '../view_model/db_provider.dart';

class CustomFlashCard extends StatelessWidget {
  final int index;
  const CustomFlashCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlashCard(
        // Adding a Key ensures the widget state resets when the index changes
        key: ValueKey(index),
        width: 360,
        height: 380,
        duration: const Duration(milliseconds: 600),
        frontWidget: () => _buildSide(context, isQuestion: false),
        backWidget: () => _buildSide(context, isQuestion: true),
      ),
    );
  }

  Widget _buildSide(BuildContext context, {required bool isQuestion}) {
    return Container(
      width: 300,
      height: 380,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isQuestion
              ? [
                  Colors.indigo.shade300,
                  Colors.indigo.shade600
                ] // Blue for Question
              : [
                  Colors.amber.shade400,
                  Colors.orange.shade500
                ], // Orange for Answer
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Consumer<DBProvider>(
          builder: (context, provider, child) {
            // Safety check for index out of bounds
            if (index >= provider.allData.length) {
              return const SizedBox.shrink();
            }

            final data = provider.allData[index];
            final text = isQuestion
                ? data[DBHelper.columnQuestion]
                : data[DBHelper.columnAnswer];

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isQuestion ? "QUESTION" : "ANSWER",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    text ?? "...",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                  ),
                  if (isQuestion) ...[
                    const SizedBox(height: 40),
                    Icon(Icons.touch_app_outlined,
                        color: Colors.white.withOpacity(0.5)),
                    Text("Tap to flip",
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5), fontSize: 10))
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
