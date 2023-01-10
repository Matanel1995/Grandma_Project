import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_signin/screens/welcome_screen.dart';
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
    if (imageTest1.length > 0) {
      Timer.periodic(const Duration(seconds: 6), (timer) {
        setState(() {
          index = (index + 1) % imageTest1.length;
          // int r = min + rnd.nextInt(max - min);
          // index = r;
          // print(r);
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('The Gallery'),
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
              }),
        ),
        // drawer: const MainDrawer(),
        body: imageTest1.isEmpty
            ? const Center(
                child: Text("There are no images yet"),
              )
            : Center(
                child: FutureBuilder(
                    future: storage.downloadURL(imageTest1[index]),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Image.network(
                            snapshot.data!,
                            fit: BoxFit.fill,
                          ),
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
