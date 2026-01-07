import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/local_database/db_helper.dart';
import '../view_model/db_provider.dart';
import '../view_model/index_provider.dart';
import '../widgets/custom_bottom_sheet.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dialog.dart';
import '../widgets/custom_flashcard.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Use CarouselSliderController for v5+, or CarouselController for older versions
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    // Use microtask to schedule the data fetch safely after the current frame
    Future.microtask(() {
      context.read<DBProvider>().getInitialData();
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int idxProvider = context.watch<IndexProvider>().idx;
    List<Map<String, dynamic>> dataProvider =
        context.watch<DBProvider>().allData;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FlashCards"),
      ),
      body: dataProvider.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.library_books_outlined,
                      size: 100, color: Colors.indigo.withOpacity(0.3)),
                  const SizedBox(height: 20),
                  Text(
                    'No Flashcards Yet!',
                    style: TextStyle(
                      color: Colors.indigo[900],
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tap the + button to create one.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: dataProvider.length,
                    itemBuilder: (context, index, realIndex) {
                      return CustomFlashCard(index: index);
                    },
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 8,
                      enlargeCenterPage: true,
                      initialPage: idxProvider,
                      onPageChanged: (index, reason) {
                        context.read<IndexProvider>().updateIdx(index);
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Navigation Controls
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filledTonal(
                          onPressed: idxProvider > 0
                              ? () {
                                  _carouselController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_back_rounded),
                          tooltip: "Previous",
                        ),
                        const SizedBox(width: 20),
                        Text(
                          "${idxProvider + 1} / ${dataProvider.length}",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(width: 20),
                        IconButton.filledTonal(
                          onPressed: idxProvider < dataProvider.length - 1
                              ? () {
                                  _carouselController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              : null,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          tooltip: "Next",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              if (dataProvider.isEmpty ||
                                  idxProvider >= dataProvider.length) {
                                return;
                              }

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPress: () async {
                                      await context
                                          .read<DBProvider>()
                                          .deleteData(
                                              sno: dataProvider[idxProvider]
                                                  [DBHelper.columnSno]);

                                      if (context.mounted) {
                                        Navigator.pop(context);
                                        _showSnackBar(
                                            "Card deleted successfully",
                                            Colors.redAccent);

                                        // Adjust index safely
                                        final newLen = context
                                            .read<DBProvider>()
                                            .allData
                                            .length;
                                        if (idxProvider >= newLen &&
                                            newLen > 0) {
                                          context
                                              .read<IndexProvider>()
                                              .updateIdx(newLen - 1);
                                        } else if (newLen == 0) {
                                          context
                                              .read<IndexProvider>()
                                              .updateIdx(0);
                                        }
                                      }
                                    },
                                  );
                                },
                              );
                            },
                            text: "Delete",
                            icon: Icons.delete_outline,
                            bgColor: Colors.red.shade100,
                            textColor: Colors.red.shade900,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomButton(
                            onPressed: () {
                              if (dataProvider.isEmpty ||
                                  idxProvider >= dataProvider.length) {
                                return;
                              }

                              showModalBottomSheet(
                                context: context,
                                elevation: 5,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return CustomBottomSheet(
                                    isEdit: true,
                                    que: dataProvider[idxProvider]
                                        [DBHelper.columnQuestion],
                                    ans: dataProvider[idxProvider]
                                        [DBHelper.columnAnswer],
                                    sno: dataProvider[idxProvider]
                                        [DBHelper.columnSno],
                                  );
                                },
                              ).then((_) {
                                // Optional: Refresh or show message if needed
                              });
                            },
                            bgColor: Colors.indigo.shade100,
                            textColor: Colors.indigo.shade900,
                            text: "Edit",
                            icon: Icons.edit_outlined,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return const CustomBottomSheet();
            },
          );
        },
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Card"),
      ),
    );
  }
}
