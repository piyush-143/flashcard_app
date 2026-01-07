import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/db_provider.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      _queController.text = widget.que;
      _ansController.text = widget.ans;
    }
  }

  @override
  void dispose() {
    _queController.dispose();
    _ansController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.isEdit ? 'Edit Card' : 'New Flashcard',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _queController,
                  maxLines: 2,
                  autofocus: !widget.isEdit,
                  decoration: const InputDecoration(
                    labelText: 'Question',
                    hintText: 'e.g., What is Flutter?',
                    prefixIcon: Icon(Icons.help_outline),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? "Please enter a question" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ansController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Answer',
                    hintText: 'e.g., A UI toolkit by Google...',
                    prefixIcon: Icon(Icons.lightbulb_outline),
                  ),
                  validator: (value) =>
                      value!.trim().isEmpty ? "Please enter an answer" : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Cancel",
                      style: TextStyle(color: Colors.grey)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        if (widget.isEdit) {
                          await context.read<DBProvider>().updateData(
                                ques: _queController.text.trim(),
                                ans: _ansController.text.trim(),
                                sno: widget.sno,
                              );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Card updated successfully!"),
                                  backgroundColor: Colors.green),
                            );
                          }
                        } else {
                          await context.read<DBProvider>().addData(
                                ques: _queController.text.trim(),
                                ans: _ansController.text.trim(),
                              );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Card added successfully!"),
                                  backgroundColor: Colors.green),
                            );
                          }
                        }
                        if (context.mounted) Navigator.pop(context);
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Something went wrong"),
                                backgroundColor: Colors.red),
                          );
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(widget.isEdit ? "Update" : "Save"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
