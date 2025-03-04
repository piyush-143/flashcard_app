import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color bgColor;
  final String text;
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.bgColor,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          // shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size(120, 20),
          side: const BorderSide(color: Colors.black)),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      ),
    );
  }
}
