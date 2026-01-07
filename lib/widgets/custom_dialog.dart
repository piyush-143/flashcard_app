import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback onPress;
  const CustomDialog({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 2)),
      content: SizedBox(
        height: 150,
        child: Column(
          spacing: 25,
          children: [
            const Text(
              "Are you sure you want to delete the flashcard ?",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w600, height: 1.2),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: onPress,
                  text: "Yes",
                  bgColor: Colors.redAccent,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  bgColor: Colors.greenAccent,
                  text: "No",
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
