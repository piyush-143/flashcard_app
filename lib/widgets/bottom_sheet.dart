import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/local_database/db_helper.dart';
import '../view_model/db_provider.dart';

class CustomBottomSheet extends StatefulWidget {
  bool isUpdate;
  int sno;
  String que;
  String ans;
  CustomBottomSheet({
    super.key,
    this.isUpdate = false,
    this.sno = 0,
    this.ans = "",
    this.que = "",
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  TextEditingController queController = TextEditingController();
  TextEditingController ansController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DBHelper? dbRef;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    queController.dispose();
    ansController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) {
      queController.text = widget.que;
      ansController.text = widget.ans;
    }
    return Container(
      height: 450,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Column(
          children: [
            Text(
              widget.isUpdate ? 'Update FlashCard' : 'Add Flash Card',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: queController,
                    keyboardType: TextInputType.none,
                    cursorColor: Colors.black,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Enter Question',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 3)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Question not entered!!!";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: ansController,
                    keyboardType: TextInputType.none,
                    cursorColor: Colors.black,
                    maxLines: 2,
                    decoration: const InputDecoration(
                      labelText: 'Enter Answer',
                      labelStyle: TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.redAccent, width: 3)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent, width: 3)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Answer not entered!!!";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.isUpdate
                              ? context.read<DBProvider>().updateData(
                                  ques: queController.text.toString(),
                                  ans: ansController.text.toString(),
                                  sno: widget.sno)
                              : context.read<DBProvider>().addData(
                                    ques: queController.text.toString(),
                                    ans: ansController.text.toString(),
                                  );
                          Navigator.pop(context);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          side: const BorderSide(color: Colors.black)),
                      child: Text(
                        widget.isUpdate ? "Update" : "Add",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 19),
                      )),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.black)),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
