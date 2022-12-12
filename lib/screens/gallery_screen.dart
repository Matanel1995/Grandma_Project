import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:google_signin/storage_service.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = './gallery-screen';
  List<String> imageTest = <String>[];
  GalleryScreen(this.imageTest, {super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState(imageTest);
}

class _GalleryScreenState extends State<GalleryScreen> {
  final Storage storage = Storage();
  List<String> imageTest1 = <String>[];
  _GalleryScreenState(this.imageTest1);

  int index = 0;

  @override
  void initState() {
    Random rnd = Random();
    int min = 0, max = imageTest1.length;

    super.initState();
    Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        index = (index + 1) % imageTest1.length;
        // int r = min + rnd.nextInt(max - min);
        // index = r;
        // print(r);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('The Gallery'),
        ),
        // drawer: const MainDrawer(),
        body: Center(
            child: FutureBuilder(
                future: storage.downloadURL(imageTest1[index]),
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
