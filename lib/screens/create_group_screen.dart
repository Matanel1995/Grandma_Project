import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/my_groups_screen.dart';

import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final controllerGroupName = TextEditingController();
  final controllerGroupPhoto = TextEditingController();
  String groupName = '';
  String photoURL = '';
  bool isCreated = false;
  String selectedImagePath = '';
  XFile? _singleImage;
  UploadTask? uploadTask;
  String finalUrl = '';

  Widget buildText(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Widget show() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        selectedImagePath.isEmpty
            ? Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/pictures/image_placeholder.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            : CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(
                  File(selectedImagePath),
                ),
              ),
        const SizedBox(height: 50),
        TextField(
          controller: controllerGroupName,
          decoration: InputDecoration(
            hintText: 'Please provide a group name',
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                // clear what's currently in the textfield
                controllerGroupName.clear();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        ),
        const Divider(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton.icon(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Theme.of(context).cardColor,
              ),
              onPressed: selectImage,
              icon: const Icon(Icons.image),
              label: buildText(context, 'Add Image'),
            ),
            const SizedBox(width: 10),
            TextButton.icon(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(20),
                backgroundColor: Theme.of(context).cardColor,
              ),
              onPressed: createGroup,
              icon: const Icon(Icons.create),
              label: buildText(context, 'Create Group'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Create Group',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          // Wrap the column with SingleChildScrollView
          child: Center(child: show()),
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

  Future createGroup() async {
    setState(() {
      groupName = controllerGroupName.text;
    });

    if (groupName != '') {
      if (selectedImagePath == '') {
        Group.createAsync(currentUser, groupName);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Congratulations!"),
                content: Text(
                    "The group $groupName has been created. \n Notice you did not add a photo to the group."),
                actions: [
                  TextButton(
                      onPressed: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return const MyGroupsScreen();
                            },
                          ),
                        );
                      }),
                      child: const Text("Ok"))
                ],
              );
            });
      } else {
        final ref = FirebaseStorage.instance
            .ref()
            .child('GroupPhotoUrl/${_singleImage!.name}');

        setState(() {
          uploadTask = ref.putFile(File(_singleImage!.path));
        });

        final snapshot = await uploadTask!.whenComplete(() {});

        final urlDownload = await snapshot.ref.getDownloadURL();

        if (urlDownload.isNotEmpty) {
          Group.createAsync(currentUser, groupName, urlDownload);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Done"),
                  content: Text("The group $groupName was created"),
                  actions: [
                    TextButton(
                        onPressed: (() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return const MyGroupsScreen();
                              },
                            ),
                          );
                        }),
                        child: const Text("Ok"))
                  ],
                );
              });
        }
        if (urlDownload.isEmpty) {
          Group.createAsync(currentUser, groupName);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Alerts"),
                  content: const Text(
                      "The photo didn't upload, but your group was created"),
                  actions: [
                    TextButton(
                        onPressed: (() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) {
                                return const MyGroupsScreen();
                              },
                            ),
                          );
                        }),
                        child: const Text("Ok"))
                  ],
                );
              });
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("You didn't chose a group name"),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                    child: const Text("Ok"))
              ],
            );
          });
    }

    setState(() {
      uploadTask = null;
    });
  }
}
