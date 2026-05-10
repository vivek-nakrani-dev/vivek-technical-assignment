import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vivek_technical_assignment/models/note_model.dart';
import 'package:vivek_technical_assignment/services/firestore_service.dart';

class NoteProvider extends ChangeNotifier {
  final FirestoreService _firestoreService;

  NoteProvider(this._firestoreService);

  StreamSubscription<List<Note>>? _subscription;

  List<Note> _notes = [];
  List<Note> get notes {
    if (_searchQuery.isEmpty) {
      return _notes;
    }

    return _notes.where((note) {
      return note.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  bool isLoading = true;
  String _searchQuery = '';


  void updateSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void listenToNotes() {
    isLoading = true;
    notifyListeners();

    _subscription?.cancel();

    _subscription = _firestoreService.getNotes().listen(
      (notes) {
        debugPrint('Notes count: ${notes.length}');
        _notes = notes;
        isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        debugPrint('Firestore Error: $error');
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
