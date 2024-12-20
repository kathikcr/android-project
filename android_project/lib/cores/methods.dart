// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:android_project/features/upload/long_video/video_deatils_page.dart';
import 'package:android_project/features/upload/notes_upload/notes_details_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
Future pickVideo(context) async {
  XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  File video = File(file!.path);
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return VideoDeatilsPage(video);
  }));
  return video;
}

Future pickNotesImage(context) async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  File notes = File(file!.path);
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return NotesDetailsPage(notes);
  }));
  return notes;
}

Future<File> pickImage() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  File image = File(file!.path);
  return image;
}

Future<String> putFileInStorage(file, number, fileType) async {
  final ref = FirebaseStorage.instance.ref().child("$fileType/$number");
  final upload = ref.putFile(file);
  final snapshot = await upload;
  String downloadUrl = await snapshot.ref.getDownloadURL();
  return downloadUrl;
}
