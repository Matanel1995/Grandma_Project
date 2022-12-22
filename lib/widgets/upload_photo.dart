import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_signin/screens/home_screen.dart';
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
  String selectedImagePath = '';
  XFile? _singleImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload Photos',
          style: Theme.of(context).textTheme.titleMedium,
        ),
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
      backgroundColor: Colors.blueGrey,
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
                    // height: 200,
                    // width: 200,
                    fit: BoxFit.cover,
                  ),
            const Text(
              'Select Image',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton.icon(
                    style: ButtonStyle(
                        // backgroundColor:
                        //     MaterialStateProperty.all(Colors.green),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 14, color: Colors.white))),
                    onPressed: () async {
                      selectImage();
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white),
                    )),
                const SizedBox(
                  width: 40,
                ),
                TextButton.icon(
                    style: ButtonStyle(
                        // backgroundColor:
                        //     MaterialStateProperty.all(Colors.green),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        textStyle: MaterialStateProperty.all(const TextStyle(
                            fontSize: 14, color: Colors.white))),
                    onPressed: () async {
                      selectedImagePath == ''
                          ? ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content: Text("No Image Selected !"),
                            ))
                          : storage
                              .uploadFile(
                                  _singleImage!.path, _singleImage!.name)
                              .then((value) {
                              return showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Done"),
                                      content: const Text(
                                          "The photo uploaded succesfully"),
                                      actions: [
                                        TextButton(
                                            onPressed: (() {
                                              Navigator.of(context).pop();
                                            }),
                                            child: const Text("Ok"))
                                      ],
                                    );
                                  });
                            });

                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Upload',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            const SizedBox(height: 10),
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
                    const Text(
                      'Select Image From !',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print('Image_Path:-');
                            print(selectedImagePath);
                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Selected !"),
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
                                    const Text('Gallery'),
                                  ],
                                ),
                              )),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print('Image_Path:-');
                            print(selectedImagePath);

                            if (selectedImagePath != '') {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("No Image Captured !"),
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
                                    const Text('Camera'),
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

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (file != null) {
      _singleImage = file;
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 75);
    if (file != null) {
      _singleImage = file;
      return file.path;
    } else {
      return '';
    }
  }

  // need to make function to select more than one image at a time and videos.
}
