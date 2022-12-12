// import 'package:flutter/material.dart';

// class UploadPhoto extends StatelessWidget {
//   static const routeName = './upload_photo';
//   const UploadPhoto({super.key});

//   Widget buildListTile(
//       String title, IconData iconData, VoidCallback tapHandler) {
//     return ListTile(
//       leading: Icon(
//         iconData,
//         size: 26,
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontFamily: 'RobotoCondensed',
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       onTap: tapHandler,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('The Score Table'),
//       // ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 120,
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             alignment: Alignment.centerLeft,
//             color: Theme.of(context).accentColor,
//             child: Text(
//               'Upload a photo',
//               style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 30,
//                   color: Theme.of(context).primaryColor),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           buildListTile('Camera', Icons.add_a_photo, () {
//             // Navigator.of(context).pushReplacementNamed('/');
//           }),
//           buildListTile('Photo Library', Icons.file_upload, () {
//             // Navigator.of(context).pushReplacementNamed(TableScore.routeName);
//           }),
//           buildListTile('Back Home', Icons.house, () {
//             Navigator.of(context).pushReplacementNamed('/');
//           }),
//         ],
//       ),
//     );
//   }
// }

// import 'dart:html';
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadPhoto extends StatefulWidget {
//   static const routeName = './upload_photo';
//   const UploadPhoto({super.key});

//   @override
//   State<UploadPhoto> createState() => _UploadPhotoState();
// }

// class _UploadPhotoState extends State<UploadPhoto> {
//   XFile? image;

//   Future _pickImage() async {
//     try {
//       final XFile? image =
//           await ImagePicker().pickImage(source: ImageSource.gallery);

//       if (image == null) return;

//       final XFile imageTemp = XFile(image.path);

//       setState(() => this.image = imageTemp);
//     } on PlatformException catch (e) {
//       print("failed to pick image: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Upload Photo',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//         ),
//         // drawer: const MainDrawer(),
//         body: Column(
//           children: [
//             // const Divider(
//             //   height: 30,
//             // ),
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   // Navigator.of(context)
//                   //     .pushReplacementNamed(PicturesScreen.routeName);
//                 },
//                 child: Container(
//                   height: 120,
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   alignment: Alignment.center,
//                   color: Colors.lightBlue,
//                   child: const Text(
//                     'Camera',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 30,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//             // const Divider(
//             //   height: 50,
//             // ),
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   // Navigator.of(context)
//                   //     .pushReplacementNamed(PicturesScreen.routeName);
//                 },
//                 child: Container(
//                   height: 120,
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(20),
//                   alignment: Alignment.center,
//                   color: Colors.purple,
//                   child: const Text(
//                     'Photo Library',
//                     style: TextStyle(
//                         fontWeight: FontWeight.w900,
//                         fontSize: 30,
//                         color: Colors.black),
//                   ),
//                 ),
//               ),
//             ),
//             // const Divider(
//             //   height: 50,
//             // ),

//             // Container(
//             //   height: 417,
//             //   width: double.infinity,
//             //   child: Image.network(
//             //     'https://hips.hearstapps.com/hbz.h-cdn.co/assets/16/26/2048x2381/hbz-queen-elizabeth-national-photo-day-1982-gettyimages-52103217.jpg?resize=980:*',
//             //     fit: BoxFit.cover,
//             //   ),
//             // ),
//             MaterialButton(
//               color: Colors.amber,
//               child: const Text(
//                 "Choose from gallery",
//                 style: TextStyle(
//                     color: Colors.white70, fontWeight: FontWeight.bold),
//               ),
//               onPressed: () {
//                 _pickImage();
//               },
//             ),
//             MaterialButton(
//               color: Colors.amber,
//               child: const Text(
//                 "Camera",
//                 style: TextStyle(
//                     color: Colors.white70, fontWeight: FontWeight.bold),
//               ),
//               onPressed: () {},
//             ),
//           ],
//         ));
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_signin/screens/home_screen.dart';
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
                  return const HomeScreen();
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
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
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
                      storage
                          .uploadFile(_singleImage!.path, _singleImage!.name)
                          .then((value) => print('Done'));
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
