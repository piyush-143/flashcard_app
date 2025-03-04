import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/local_database/db_helper.dart';
import '../view_model/db_provider.dart';
import 'custom_button.dart';

class CustomBottomSheet extends StatefulWidget {
  final bool isEdit;
  final int sno;
  final String que;
  final String ans;
  const CustomBottomSheet({
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
  final TextEditingController _queController = TextEditingController();
  final TextEditingController _ansController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DBHelper? dbRef;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _queController.dispose();
    _ansController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEdit) {
      _queController.text = widget.que;
      _ansController.text = widget.ans;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 10),
      child: Column(
        children: [
          Text(
            widget.isEdit ? 'Edit FlashCard' : 'Add Flash Card',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _queController,
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
                    return value!.isEmpty ? "Question not entered!!!" : null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _ansController,
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
                    return value!.isEmpty ? "Question not entered!!!" : null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.isEdit
                        ? context.read<DBProvider>().updateData(
                            ques: _queController.text,
                            ans: _ansController.text,
                            sno: widget.sno)
                        : context.read<DBProvider>().addData(
                              ques: _queController.text,
                              ans: _ansController.text,
                            );
                    Navigator.pop(context);
                  }
                },
                bgColor: Colors.greenAccent,
                text: widget.isEdit ? "Save" : "Add",
              ),
              const SizedBox(width: 30),
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Cancel",
                bgColor: Colors.redAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
