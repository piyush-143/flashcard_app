import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';

class CustomFlashCard extends StatelessWidget {
  final String que;
  final String ans;
  const CustomFlashCard({super.key, required this.que, required this.ans});

  @override
  Widget build(BuildContext context) {
    return FlashCard(
      width: 310,
      height: 350,
      //controller: cardController,
      duration: const Duration(milliseconds: 500),
      frontWidget: () => Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Center(
          child: Text(
            "Ans.$ans",
            style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
      backWidget: () => Container(
        decoration: BoxDecoration(
            color: Colors.black12,
            border: Border.all(color: Colors.black, width: 1.5)),
        child: Center(
          child: Text(
            "Q.$que",
            style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 30,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}
