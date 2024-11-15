import 'dart:io';
import 'package:android_project/features/upload/notes_upload/notes_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:android_project/cores/methods.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NotesDetailsPage extends ConsumerStatefulWidget {
  final File? notes;
  const NotesDetailsPage(this.notes, {super.key});

  @override
  ConsumerState<NotesDetailsPage> createState() => _NotesDeatilsPageState();
}

class _NotesDeatilsPageState extends ConsumerState<NotesDetailsPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  bool isThumbnailSelected = false;
  String randomNumber = const Uuid().v4();
  String noteId = const Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Enter the Title",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Enter the title",
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Enter the Description",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                    hintText: "Enter the Description",
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              //select thumbnail
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      //pick image
                      image = await pickImage();
                      isThumbnailSelected = true;
                      setState(() {});
                    },
                    child: const Text(
                      "Select Thumbnail",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              isThumbnailSelected
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 12,
                      ),
                      child: Image.file(
                        image!,
                        cacheHeight: 160,
                        cacheWidth: 400,
                      ),
                    )
                  : const SizedBox(),

              isThumbnailSelected
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(11),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            //publish video
                            String thumbnail = await putFileInStorage(
                                image, randomNumber, "image");
                            String noteUrl = await putFileInStorage(
                                widget.notes, randomNumber, "image");
                            ref.watch(imageProvider).uploadNotesToFirestore(
                                notesUrl: noteUrl,
                                thumbnail: thumbnail,
                                title: titleController.text,
                                description: descriptionController.text,
                                noteId: noteId,
                                datePublished: DateTime.now(),
                                userId: FirebaseAuth.instance.currentUser!.uid);
                          },
                          child: const Text(
                            "Publish",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
