import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_signin/storage_service.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = './pictures-screen';
  List<String> imageTest = <String>[];
  GalleryScreen(this.imageTest);

  @override
  State<GalleryScreen> createState() => _PicturesScreenState(imageTest);
}

class _PicturesScreenState extends State<GalleryScreen> {
  final Storage storage = Storage();
  List<String> imageTest1 = <String>[];
  _PicturesScreenState(this.imageTest1);

  // List<String> image_name = <String>[];
  // _PicturesScreenState(this.image_name);

  // void getImages() async {
  //   final firebase_storage.ListResult result = await firebase_storage
  //       .FirebaseStorage.instance
  //       .ref()
  //       .child("test")
  //       .listAll();
  //   for (var i = 0; i < result.items.length; i++) {
  //     image_name.add(result.items[i].name);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('The Gallery'),
        ),
        // drawer: const MainDrawer(),
        body: Center(
            child: FutureBuilder(
                future: storage
                    .downloadURL('scaled_image_picker1555005536174115340.jpg'),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return Container();
                })));
  }
}
