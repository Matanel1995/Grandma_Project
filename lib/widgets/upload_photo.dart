import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../storage_service.dart';

class UploadPhoto extends StatefulWidget {
  static const routeName = './upload_photo';
  const UploadPhoto({Key? key}) : super(key: key);

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  final Storage storage = Storage();
  final testStorage = FirebaseStorage.instance;
  List<String> selectedImagePaths = [];
  List<XFile>? _selectedImages;
  List<UploadTask?> uploadTasks = [];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool hasSelectedImages = selectedImagePaths.isNotEmpty;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: const Text('Upload Photos'),
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
            hasSelectedImages
                ? Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 1.0,
                          initialPage: _currentIndex,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
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
                      const SizedBox(height: 10),
                      DotsIndicator(
                        dotsCount: selectedImagePaths.length,
                        position: _currentIndex.toDouble(),
                        decorator: DotsDecorator(
                          activeColor: Colors.blue,
                          activeSize: const Size(12, 12),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          spacing: const EdgeInsets.all(3),
                        ),
                      ),
                    ],
                  )
                : Image.asset(
                    './assets/pictures/image_placeholder.png',
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
            if (!hasSelectedImages) buildText(context, 'Select Image'),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(20),
                    ),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    selectImages();
                    setState(() {});
                  },
                  icon: const Icon(Icons.image),
                  label: buildText(context, 'Add Image'),
                ),
                const SizedBox(
                  width: 40,
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(20),
                    ),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
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
                  icon: const Icon(Icons.send),
                  label: buildText(context, 'Upload'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // buildProgress(),
          ],
        ),
      ),
    );
  }

  // Future selectImages() async {
  //   List<XFile>? images = await ImagePicker().pickMultiImage(
  //     imageQuality: 10,
  //   );

  //   if (images != null && images.isNotEmpty) {
  //     _selectedImages = images;
  //     selectedImagePaths = images.map((image) => image.path).toList();
  //     setState(() {});
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: buildText(context, 'No Images Selected!'),
  //       ),
  //     );
  //   }
  // }

  Future selectImages() async {
    final ImagePicker _picker = ImagePicker();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Card(
                        color: Colors.grey,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset(
                              './assets/pictures/camera.png',
                              height: 60,
                              width: 60,
                            )
                          ]),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop('camera');
                      },
                    ),
                    GestureDetector(
                      child: Card(
                        color: Colors.grey,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Image.asset(
                              './assets/pictures/gallery.png',
                              height: 60,
                              width: 60,
                            )
                          ]),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop('gallery');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((value) async {
      if (value == 'camera') {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          _selectedImages = [image];
          selectedImagePaths = [image.path];
          setState(() {});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: buildText(context, 'No Image Selected!'),
            ),
          );
        }
      } else if (value == 'gallery') {
        List<XFile>? images = await _picker.pickMultiImage(
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
    });
  }

  // Future uploadFiles() async {
  //   for (int i = 0; i < _selectedImages!.length; i++) {
  //     final ref = FirebaseStorage.instance
  //         .ref()
  //         .child('${currentUser.currentGroupId}/${_selectedImages![i].name}');

  //     setState(() {
  //       uploadTasks.add(ref.putFile(File(_selectedImages![i].path)));
  //     });

  //     final snapshot = await uploadTasks[i]!.whenComplete(() {});

  //     final urlDownload = await snapshot.ref.getDownloadURL();
  //     if (urlDownload.isNotEmpty) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: buildTitle(context, 'Done'),
  //             content: buildText(context, 'The photo uploaded successfully'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                       builder: (_) => const UploadPhoto(),
  //                     ),
  //                   );
  //                 },
  //                 child: buildText(context, 'OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }
  //     if (urlDownload.isEmpty) {
  //       showDialog(
  //         context: context,
  //         builder: (BuildContext context) {
  //           return AlertDialog(
  //             title: buildTitle(context, 'Error'),
  //             content: buildText(context, 'The photo didn\'t upload'),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: buildText(context, 'OK'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     }

  //     setState(() {
  //       uploadTasks[i] = null;
  //     });
  //   }
  // }
  Future uploadFiles() async {
    bool hasError = false;
    int uploadedCount = 0;

    for (int i = 0; i < _selectedImages!.length; i++) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('${currentUser.currentGroupId}/${_selectedImages![i].name}');

      final uploadTask = ref.putFile(File(_selectedImages![i].path));

      showDialog(
        context: context,
        barrierDismissible: false, // Prevent dialog dismissal
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                const SizedBox(height: 16),
                buildText(
                    context, 'Uploading ${i + 1}/${_selectedImages!.length}'),
              ],
            ),
          );
        },
      );

      // Wait for the upload to complete
      await uploadTask.whenComplete(() {});

      Navigator.pop(context); // Dismiss the progress dialog

      if (uploadTask.snapshot.state == TaskState.success) {
        uploadedCount++;
      } else {
        hasError = true;
        break; // Exit the loop if an error occurred
      }
    }

    if (uploadedCount == _selectedImages!.length && !hasError) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: buildTitle(context, 'Done'),
            content: buildText(context,
                'Uploaded $uploadedCount/${_selectedImages!.length} photos successfully'),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: buildTitle(context, 'Error'),
            content: buildText(context, 'An error occurred during upload'),
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

  // Widget buildText(BuildContext context, String text) {
  //   return Text(
  //     text,
  //     style: TextStyle(
  //       fontSize: 14,
  //       color: Theme.of(context).cardColor,
  //     ),
  //   );
  // }

  // Widget buildTitle(BuildContext context, String text) {
  //   return Text(
  //     text,
  //     style: TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.bold,
  //       color: Theme.of(context).cardColor,
  //     ),
  //   );
  // }
}
