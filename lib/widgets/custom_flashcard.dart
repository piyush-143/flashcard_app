import 'package:flutter/material.dart';
import 'package:flash_card/flash_card.dart';

class CustomFlashCard extends StatefulWidget {
  const CustomFlashCard({super.key});

  @override
  State<CustomFlashCard> createState() => _CustomFlashCardState();
}

class _CustomFlashCardState extends State<CustomFlashCard> {
  FlashCardController cardController = FlashCardController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.greenAccent,
          child: FlashCard(
            controller: cardController,
            duration: const Duration(milliseconds: 600),
            frontWidget: () => Container(
                color: Colors.redAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://fn.vinhphuc.edu.vn/UploadImages/mnhoanglau/admin/anh%20nha.jpg?w=700',
                      width: 100,
                      height: 100,
                    ),
                    const Text.rich(TextSpan(
                        text: 'Nghĩa:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        children: [
                          TextSpan(
                            text: 'Ngôi nhà',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ])),
                    const Text.rich(TextSpan(
                        text: 'Phiên âm:',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        children: [
                          TextSpan(
                            text: '/həʊm/',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )
                        ])),
                    Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.blue, width: 2),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                spreadRadius: 1,
                                blurRadius: 15)
                          ]),
                      child: const Center(
                          child: Icon(Icons.volume_down_sharp,
                              color: Colors.blue)),
                    ),
                  ],
                )),
            backWidget: () => Container(
              height: 100,
              width: 100,
              color: Colors.lightBlueAccent,
              child: const Center(
                child: Text(
                  'Home 1',
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            width: 300,
            height: 400,
          ),
        ),
      ),
    );
  }
}
