import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vivek_technical_assignment/models/note_model.dart';
import 'package:vivek_technical_assignment/services/firestore_service.dart';
import 'package:vivek_technical_assignment/utils/app_toast.dart';
import 'package:vivek_technical_assignment/widgets/app_button.dart';

class ManageNotesDialog extends StatefulWidget {
  final Note? note;

  const ManageNotesDialog({super.key, this.note});

  @override
  State<ManageNotesDialog> createState() => _ManageNotesDialogState();
}

class _ManageNotesDialogState extends State<ManageNotesDialog> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _messageController.text = widget.note!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.note != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Note' : 'Add Note'),
      backgroundColor: Colors.white,
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              validator: (value) => (value?.trim().isEmpty ?? false) ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'content', border: OutlineInputBorder()),
              validator: (value) => (value?.trim().isEmpty ?? false) ? 'Please enter a content' : null,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            SizedBox(width: 10.w),
            Flexible(
              child: AppButton(
                text: 'Cancel',
                radius: 20.r,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                onPressed: () {
                  context.pop();
                },
              ),
            ),
            SizedBox(width: 10.w),
            Flexible(
              child: AppButton(
                text: isEditing ? 'Edit' : 'Add',
                radius: 20.r,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final firestoreService = context.read<FirestoreService>();
                    try {
                      if (isEditing) {
                        await firestoreService.updateNote(
                          id: widget.note!.id,
                          title: _titleController.text,
                          content: _messageController.text,
                        );
                      } else {
                        await firestoreService.addNote(title: _titleController.text, content: _messageController.text);
                      }
                      if (!context.mounted) return;
                      context.pop();
                    } catch (e) {
                      appToast(message: "Failed to save note: $e");
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
