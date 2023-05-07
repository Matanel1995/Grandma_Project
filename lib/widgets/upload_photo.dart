import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../storage_service.dart';

class UploadPhoto extends StatefulWidget {
  static const routeName = './upload_photo';
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UploadPhoto> {
  final Storage storage = Storage();
  final testStorage = FirebaseStorage.instance;
  List<String> selectedImagePaths = [];
  List<XFile>? _selectedImages;
  List<UploadTask?> uploadTasks = [];

  @override
  Widget build(BuildContext context) {
    bool hasSelectedImages = selectedImagePaths.isEmpty;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'Upload Photos'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return const WelcomeScreen();
                },
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            selectedImagePaths.isEmpty
                ? Image.asset(
                    './assets/pictures/image_placeholder.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  )
                : CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.0,
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: selectedImagePaths.map((path) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.file(
                            File(path),
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }).toList(),
                  ),
            if (hasSelectedImages) buildText(context, 'Select Image'),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).cardColor,
                    )),
                  ),
                  onPressed: () async {
                    selectImages();
                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.image,
                    color: Colors.white,
                  ),
                  label: buildText(context, 'Add Image'),
                ),
                const SizedBox(
                  width: 40,
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 14, color: Theme.of(context).cardColor)),
                  ),
                  onPressed: () async {
                    if (selectedImagePaths.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: buildText(context, 'No Image Selected!'),
                        ),
                      );
                    } else {
                      uploadFiles();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: buildText(context, 'Upload'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildProgress(),
          ],
        ),
      ),
    );
  }

  Future selectImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage(
      imageQuality: 10,
    );

    if (images != null && images.isNotEmpty) {
      _selectedImages = images;
      selectedImagePaths = images.map((image) => image.path).toList();
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: buildText(context, 'No Images Selected!'),
        ),
      );
    }
  }

  Future uploadFiles() async {
    for (int i = 0; i < _selectedImages!.length; i++) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('${currentUser.currentGroupId}/${_selectedImages![i].name}');

      setState(() {
        uploadTasks.add(ref.putFile(File(_selectedImages![i].path)));
      });

      final snapshot = await uploadTasks[i]!.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      if (urlDownload.isNotEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: buildTitle(context, 'Done'),
              content: buildText(context, 'The photo uploaded successfully'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const UploadPhoto(),
                      ),
                    );
                  },
                  child: buildText(context, 'OK'),
                ),
              ],
            );
          },
        );
      }
      if (urlDownload.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: buildTitle(context, 'Error'),
              content: buildText(context, 'The photo didn\'t upload'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: buildText(context, 'OK'),
                ),
              ],
            );
          },
        );
      }

      setState(() {
        uploadTasks[i] = null;
      });
    }
  }

  Widget buildProgress() => Column(
        children: List.generate(
          uploadTasks.length,
          (index) => StreamBuilder<TaskSnapshot>(
            stream: uploadTasks[index]?.snapshotEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;
                double progress = data.bytesTransferred / data.totalBytes;

                return SizedBox(
                  height: 50,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey,
                        color: Colors.green,
                      ),
                      Center(
                        child: Text(
                          '${(100 * progress).roundToDouble()}%',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox(
                  height: 50,
                );
              }
            },
          ),
        ),
      );

  // Rest of the code...
}
