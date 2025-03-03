import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashcard_app/view_model/db_provider.dart';
import 'package:flashcard_app/view_model/index_provider.dart';
import 'package:flashcard_app/widgets/custom_dialog.dart';
import 'package:flashcard_app/widgets/custom_flashcard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/local_database/db_helper.dart';
import '../widgets/bottom_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final idx = context.watch<IndexProvider>().idx;
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
      body: Consumer<DBProvider>(
        builder: (ctx, value, child) {
          List<Map<String, dynamic>> providerData = value.allData();
          return providerData.isEmpty
              ? const Center(child: Text('Empty'))
              // : ListView.builder(
              //     itemCount: providerData.length,
              //     itemBuilder: (ctx, index) {
              //       return ListTile(
              //         title: Text(providerData[index][DBHelper.columnQuestion]),
              //         subtitle:
              //             Text(providerData[index][DBHelper.columnAnswer]),
              //         leading: CircleAvatar(child: Text(index.toString())),
              //         trailing: Row(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             IconButton(
              //                 onPressed: () {
              //                   showModalBottomSheet(
              //                     context: context,
              //                     builder: (context) {
              //                       return CustomBottomSheet(
              //                         isUpdate: true,
              //                         que: providerData[index]
              //                             [DBHelper.columnQuestion],
              //                         ans: providerData[index]
              //                             [DBHelper.columnAnswer],
              //                         sno: providerData[index]
              //                             [DBHelper.columnSno],
              //                       );
              //                     },
              //                   );
              //                 },
              //                 icon: const Icon(Icons.edit)),
              //             IconButton(
              //                 onPressed: () {
              //                   showDialog(
              //                     context: context,
              //                     builder: (context) {
              //                       return CustomDialog(
              //                         onPress: () {
              //                           context.read<DBProvider>().deleteData(
              //                               sno: providerData[index]
              //                                   [DBHelper.columnSno]);
              //                           Navigator.pop(context);
              //                         },
              //                       );
              //                     },
              //                   );
              //                 },
              //                 icon: const Icon(Icons.delete)),
              //           ],
              //         ),
              //       );
              //     },
              //   );
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          enableInfiniteScroll: false),
                      itemCount: providerData.length,
                      itemBuilder: (context, index, realIndex) {
                        return CustomFlashCard(
                          que: providerData[index][DBHelper.columnQuestion],
                          ans: providerData[index][DBHelper.columnAnswer],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    onPress: () {
                                      context.read<DBProvider>().deleteData(
                                          sno: providerData[idx]
                                              [DBHelper.columnSno]);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                side: const BorderSide(color: Colors.black)),
                            child: const Text(
                              'Delete',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            )),
                        OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CustomBottomSheet(
                                  isUpdate: true,
                                  que: providerData[idx]
                                      [DBHelper.columnQuestion],
                                  ans: providerData[idx][DBHelper.columnAnswer],
                                  sno: providerData[idx][DBHelper.columnSno],
                                );
                              },
                            );
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.greenAccent,
                              side: const BorderSide(color: Colors.black)),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return CustomBottomSheet();
            },
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
          );
        },
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.greenAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
