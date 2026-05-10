import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vivek_technical_assignment/providers/notes/note_provider.dart';
import 'package:vivek_technical_assignment/services/firebase_auth_service.dart';
import 'package:vivek_technical_assignment/services/firestore_service.dart';
import 'package:vivek_technical_assignment/widgets/app_bottom_sheet.dart';
import 'package:vivek_technical_assignment/widgets/app_button.dart';
import 'package:vivek_technical_assignment/widgets/manage_notes_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 50.h),
            CircleAvatar(
              radius: 50.r,
              backgroundColor: Colors.grey.shade500,
              child: FittedBox(
                child: Icon(Icons.person, size: 70.sp, color: Colors.black),
              ),
            ),
            SizedBox(height: 10.h),
            Text(FirebaseAuth.instance.currentUser?.email ?? "No Email", style: TextStyle(fontSize: 18.sp)),
            SizedBox(height: 20.h),
            AppButton(
              text: 'Logout',
              radius: 40.r,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              onPressed: () {
                logOutSheet(
                  context: context,
                  onLogOut: () async {
                    await context.read<FirebaseAuthService>().signOut();
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          if (noteProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = noteProvider.notes;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: TextField(
                  onChanged: noteProvider.updateSearchQuery,
                  onTapOutside: (_) {
                    FocusScope.of(context).unfocus();
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Search notes...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                ),
              ),

              Expanded(
                child: notes.isEmpty
                    ? const Center(child: Text("No notes found."))
                    : ListView.builder(
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: notes.length,
                        itemBuilder: (context, index) {
                          final note = notes[index];

                          return Container(
                            padding: EdgeInsets.only(top: 15.h, bottom: 15.h, left: 25.w, right: 10.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(color: Colors.black),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(note.title),
                                      Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),

                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => ManageNotesDialog(note: note),
                                        );
                                      },
                                      visualDensity: VisualDensity.compact,
                                    ),

                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        deleteNoteSheet(
                                          context: context,
                                          onDelete: () {
                                            final firestoreService = context.read<FirestoreService>();

                                            firestoreService.deleteNote(id: note.id);

                                            context.pop();
                                          },
                                        );
                                      },
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () => showDialog(context: context, builder: (context) => const ManageNotesDialog()),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
