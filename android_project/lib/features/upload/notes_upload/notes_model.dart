import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotesModel {
  final String notesUrl;
  final String thumbnail;
  final String title;
  final String description;
  final DateTime datePublished;
  final int views;
  final String noteId;
  final String userId;
  final List likes;
  final String type;
  NotesModel({
    required this.notesUrl,
    required this.thumbnail,
    required this.title,
    required this.description,
    required this.datePublished,
    required this.views,
    required this.noteId,
    required this.userId,
    required this.likes,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notesUrl': notesUrl,
      'thumbnail': thumbnail,
      'title': title,
      'description': description,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'views': views,
      'noteId': noteId,
      'userId': userId,
      'likes': likes,
      'type': type,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      notesUrl: map['notesUrl'] as String? ?? '',
      thumbnail: map['thumbnail'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      datePublished: map['datePublished'] is Timestamp
          ? (map["datePublished"] as Timestamp).toDate()
          : (map["datepublished"] != null
              ? DateTime.fromMillisecondsSinceEpoch(map["datepublished"] as int)
              : DateTime.now()), // Default to current date if null
      views: map['views'] as int? ?? 0,
      noteId: map['noteId'] as String? ?? '',
      userId: map['userId'] as String? ?? '',
      likes: map['likes'] as List? ?? [],
      type: map['type'] as String? ?? '',
    );
  }
}
