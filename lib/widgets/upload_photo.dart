import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

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
  String selectedImagePath = '';
  XFile? _singleImage;
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
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
            selectedImagePath == ''
                ? Image.asset(
                    './assets/pictures/image_placeholder.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  )
                : Image.file(
                    File(selectedImagePath),
                    fit: BoxFit.cover,
                  ),
            buildText(context, 'Select Image'),
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
                        ))),
                    onPressed: () async {
                      selectImage();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    label: buildText(context, 'Add Image')),
                const SizedBox(
                  width: 40,
                ),
                TextButton.icon(
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 14, color: Theme.of(context).cardColor))),
                    onPressed: () async {
                      selectedImagePath == ''
                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  buildText(context, 'No Image Selected !'),
                            ))
                          : uploadFile();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: buildText(context, 'Upload')),
              ],
            ),
            const SizedBox(height: 10),
            buildProgress()
          ],
        ),
      ),
    );
  }

  Future selectImage() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    buildText(context, 'Select Image From !'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    buildText(context, 'No Image Selected !'),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      './assets/pictures/gallery.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    buildText(context, 'Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    buildText(context, 'No Image Captured !'),
                              ));
                            }
                          },
                          child: Card(
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      './assets/pictures/camera.png',
                                      height: 60,
                                      width: 60,
                                    ),
                                    buildText(context, 'Camera'),
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future uploadFile() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('${currentUser.currentGroupId}/${_singleImage!.name}');

    setState(() {
      uploadTask = ref.putFile(File(_singleImage!.path));
    });

    final snapshot = await uploadTask!.whenComplete(() {});

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
                    onPressed: (() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) {
                            return const UploadPhoto();
                          },
                        ),
                      );
                    }),
                    child: buildText(context, 'OK'))
              ],
            );
          });
    }
    if (urlDownload.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: buildTitle(context, 'Error'),
              content: buildText(context, 'The photo didn\'t uploaded'),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: buildText(context, 'OK'))
              ],
            );
          });
    }

    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: ((context, snapshot) {
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
                  )
                ],
              ),
            );
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        }),
      );

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      _singleImage = file;
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      _singleImage = file;
      return file.path;
    } else {
      return '';
    }
  }

  // need to make function to select more than one image at a time and videos.
}
