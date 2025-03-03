import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  VoidCallback onPress;
  CustomDialog({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 2)),
      content: Container(
        //width: 450,
        height: 150,
        child: Column(
          children: [
            const Text(
              "Are you sure you want to delete the flashcard ?",
              style: TextStyle(fontSize: 25.5, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                      onPressed: onPress,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.black)),
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      )),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        side: const BorderSide(color: Colors.black)),
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
