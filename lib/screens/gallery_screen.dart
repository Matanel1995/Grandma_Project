import 'dart:ffi';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_signin/storage_service.dart';
import 'package:google_signin/widgets/upload_photo.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import '../widgets/main_drawer.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = './pictures-screen';

  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<GalleryScreen> {
  final Storage storage = Storage();
  List<String> image_name = <String>[];

  void getImages() async {
    final firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("test")
        .listAll();
    for (var i = 0; i < result.items.length; i++) {
      image_name.add(result.items[i].name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Gallery'),
      ),
      // drawer: const MainDrawer(),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              future: storage.downloadURL(image_name[1]),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
