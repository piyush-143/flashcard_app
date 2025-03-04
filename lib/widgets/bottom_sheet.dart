import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/local_database/db_helper.dart';
import '../view_model/db_provider.dart';
import 'custom_button.dart';

class CustomBottomSheet extends StatefulWidget {
  bool isEdit;
  int sno;
  String que;
  String ans;
  CustomBottomSheet({
    super.key,
    this.isEdit = false,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      queController.text = widget.que;
      ansController.text = widget.ans;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          children: [
            Text(
              widget.isEdit ? 'Edit FlashCard' : 'Add Flash Card',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: queController,
                    keyboardType: TextInputType.text,
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
                    height: 10,
                  ),
                  TextFormField(
                    controller: ansController,
                    keyboardType: TextInputType.text,
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.isEdit
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
                  bgColor: Colors.greenAccent,
                  text: widget.isEdit ? "Save" : "Add",
                ),
                const SizedBox(
                  width: 30,
                ),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Cancel",
                  bgColor: Colors.redAccent,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
