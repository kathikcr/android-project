// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:android_project/features/upload/notes_upload/notes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final imageProvider =
    Provider((ref) => NotesRepository(firestore: FirebaseFirestore.instance));

class NotesRepository {
  FirebaseFirestore firestore;
  NotesRepository({
    required this.firestore,
  });
  uploadNotesToFirestore({
    required String notesUrl,
    required String thumbnail,
    required String title,
    required String description,
    required String noteId,
    required DateTime datePublished,
    required String userId,
  }) async {
    NotesModel notes = NotesModel(
        notesUrl: notesUrl,
        thumbnail: thumbnail,
        title: title,
        description: description,
        datePublished: datePublished,
        views: 0,
        noteId: notesUrl,
        userId: userId,
        likes: [],
        type: "images");
    await firestore.collection("notes").doc(noteId).set(notes.toMap());
  }

  Future<void> likeNotes({
    required List? likes,
    required noteId,
    required currentUserId,
  }) async {
    if (!likes!.contains(currentUserId)) {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(noteId)
          .update({"likes": FieldValue.arrayUnion([])});
    }
    if (likes.contains(currentUserId)) {
      await FirebaseFirestore.instance
          .collection("notes")
          .doc(noteId)
          .update({"likes": FieldValue.arrayRemove([])});
    }
  }
}
