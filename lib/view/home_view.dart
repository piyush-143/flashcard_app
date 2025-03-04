import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashcard_app/view_model/db_provider.dart';
import 'package:flashcard_app/view_model/index_provider.dart';
import 'package:flashcard_app/widgets/custom_dialog.dart';
import 'package:flashcard_app/widgets/custom_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/local_database/db_helper.dart';
import '../widgets/bottom_sheet.dart';
import '../widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DBProvider>().getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    int idx = context.watch<IndexProvider>().idx;
    List<Map<String, dynamic>> providerData =
        context.watch<DBProvider>().allData();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FlashCard App",
          style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
        toolbarHeight: 65,
      ),
      body: providerData.isEmpty
          ? const Center(
              child: Text(
              'Empty!\nAdd some FlashCard',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                CarouselSlider.builder(
                  //carouselController: carouselSliderController,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      context.read<IndexProvider>().updateIdx(index);
                    },
                    height: 340,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeFactor: 0.4,
                    viewportFraction: 0.76,
                    enableInfiniteScroll: false,
                  ),
                  itemCount: providerData.length,
                  itemBuilder: (ctx, index, realIndex) {
                    return CustomFlashCard(
                      index: index,
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialog(
                              onPress: () {
                                context.read<DBProvider>().deleteData(
                                    sno: providerData[idx][DBHelper.columnSno]);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                      text: "Delete",
                      bgColor: Colors.redAccent,
                    ),
                    CustomButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          elevation: 3,
                          isScrollControlled: true,
                          constraints: const BoxConstraints(maxHeight: 550),
                          builder: (context) {
                            return CustomBottomSheet(
                              isEdit: true,
                              que: providerData[idx][DBHelper.columnQuestion],
                              ans: providerData[idx][DBHelper.columnAnswer],
                              sno: providerData[idx][DBHelper.columnSno],
                            );
                          },
                        );
                      },
                      bgColor: Colors.greenAccent,
                      text: "Edit",
                    )
                  ],
                ),
              ],
            ),
      floatingActionButton: Align(
        alignment: const Alignment(0.9, 0.94),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return CustomBottomSheet();
              },
              isScrollControlled: true,
              elevation: 3,
              constraints: const BoxConstraints(maxHeight: 550),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
            );
          },
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.greenAccent,
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
