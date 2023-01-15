import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/home_screen.dart';
import 'package:google_signin/screens/my_groups_screen.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(
  //       const Duration(seconds: 5),
  //       () => Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => MyGroupsScreen())));
  // }

  final controllerGroupName = TextEditingController();
  final controllerGroupPhoto = TextEditingController();
  String groupName = '';
  String photoURL = '';
  bool isCreated = false;
  String selectedImagePath = '';
  XFile? _singleImage;
  UploadTask? uploadTask;
  String finalUrl = '';

  // Widget showError() {
  //   return const Expanded(
  //     child: Center(
  //         child: Text(
  //       'You did not pick a group name.',
  //       style: TextStyle(color: Colors.black, fontSize: 20),
  //     )),
  //   );
  // }

  Widget show() {
    // if (isCreated) {
    //   //display text
    //   return Center(
    //       child: Text(
    //     'congratulations!!\nThe group $groupName has been created! \nYou can go back now.',
    //     style: const TextStyle(color: Colors.black, fontSize: 20),
    //   ));
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        selectedImagePath == ''
            ? Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                child: Image.asset(
                  './assets/pictures/image_placeholder.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              )
            : CircleAvatar(
                radius: 100,
                backgroundImage: FileImage(
                  File(selectedImagePath),
                ),
              ),
        const SizedBox(
          height: 50,
        ),
        TextField(
          controller: controllerGroupName,
          decoration: InputDecoration(
              hintText: 'Please provide a group name?',
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  // clear what's currently in the textfield
                  controllerGroupName.clear();
                },
                icon: const Icon(Icons.clear),
              )),
        ),
        const Divider(
          height: 20,
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
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14, color: Colors.white))),
                onPressed: () async {
                  selectImage();
                  setState(() {});
                },
                icon: const Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: const Text(
                  'Add Image',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton.icon(
                style: ButtonStyle(
                    // backgroundColor:
                    //     MaterialStateProperty.all(Colors.green),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    textStyle: MaterialStateProperty.all(
                        const TextStyle(fontSize: 14, color: Colors.white))),
                onPressed: () async {
                  createGroup();

                  // setState(() {
                  //   groupName = controllerGroupName.text;
                  //   photoURL = _singleImage!.name;
                  // });
                  // if (groupName != '') {
                  //   if (photoURL == "") {
                  //     // no selected photo
                  //     print("Create group with no image");
                  //     Group.createAsync(currentUser, groupName);
                  //   } else {
                  //     // there is a selected photo
                  //     print("Create group with image");
                  //     // print(urlDownload);
                  //     print(finalUrl);
                  //     Group.createAsync(currentUser, groupName, finalUrl);
                  //   }
                  // auto switching page after 5 secondss
                  // Timer(
                  //     const Duration(seconds: 5),
                  //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //         builder: (BuildContext context) => MyGroupsScreen())));

                  // isCreated = true;
                  // } else {
                  //   showError();
                  // }
                },
                icon: const Icon(
                  Icons.create,
                  color: Colors.black,
                ),
                label: const Text(
                  'Create Group',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        ),
        // MaterialButton(
        //   // update the group name
        //   onPressed: () => Navigator.of(context).pushReplacement(
        //       MaterialPageRoute(
        //           builder: (BuildContext context) => const MyGroupsScreen())),
        //   color: Colors.purple,
        //   child: const Text(
        //     'Back To My Groups',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Group',
          style: Theme.of(context).textTheme.titleMedium,
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
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     show(),
        //   ],
        // ),
        child: Center(child: show()),
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
                title: const Text("Error"),
                content: Text(
                    "You created a group without an image group name: $groupName"),
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
                  title: const Text("Error"),
                  content: const Text(
                      "The photo didn\'t upload, but your group was created"),
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
    // print('Download Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }
}
