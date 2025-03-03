import 'package:flashcard_app/view_model/db_provider.dart';
import 'package:flashcard_app/widgets/custom_dialog.dart';
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
  DBHelper? dbRef;
  List<Map<String, dynamic>> allData = [];

  @override
  void initState() {
    super.initState();
    context.read<DBProvider>().getInitialData();
  }

  void getData() async {
    allData = await dbRef!.getAllData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FlashCard App",
          style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Consumer<DBProvider>(
        builder: (ctx, value, child) {
          List<Map<String, dynamic>> providerData = value.getNotes();
          return providerData.isEmpty
              ? const Center(child: Text('Empty'))
              : ListView.builder(
                  itemCount: providerData.length,
                  itemBuilder: (ctx, index) {
                    return ListTile(
                      title: Text(providerData[index][DBHelper.columnQuestion]),
                      subtitle:
                          Text(providerData[index][DBHelper.columnAnswer]),
                      leading: CircleAvatar(child: Text(index.toString())),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return CustomBottomSheet(
                                      isUpdate: true,
                                      que: providerData[index]
                                          [DBHelper.columnQuestion],
                                      ans: providerData[index]
                                          [DBHelper.columnAnswer],
                                      sno: providerData[index]
                                          [DBHelper.columnSno],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      onPress: () {
                                        context.read<DBProvider>().deleteData(
                                            sno: providerData[index]
                                                [DBHelper.columnSno]);
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    );
                  },
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
