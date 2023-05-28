import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:google_signin/storage_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui' as ui;

class GalleryScreen extends StatefulWidget {
  static const routeName = './gallery-screen';
  final List<String> imageTest;

  GalleryScreen(this.imageTest, {Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState(imageTest);
}

class _GalleryScreenState extends State<GalleryScreen> {
  final Storage storage = Storage();
  List<String> imageTest;
  late Timer timer;
  int index = 0;
  bool showGrid = false; // Track whether to show the grid or carousel

  _GalleryScreenState(this.imageTest);

  // @override
  // void initState() {
  //   super.initState();
  //   if (!showGrid && imageTest.isNotEmpty) {
  //     timer = Timer.periodic(const Duration(seconds: 5), (timer) {
  //       setState(() {
  //         index = (index + 1) % imageTest.length;
  //       });
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'The Gallery'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const WelcomeScreen(),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(showGrid ? Icons.photo : Icons.grid_view),
            onPressed: () {
              setState(() {
                showGrid = !showGrid;
                if (!showGrid && imageTest.isNotEmpty) {
                  index = 0;
                }
              });
            },
          ),
        ],
      ),
      body: imageTest.isEmpty
          ? Center(
              child: buildText(context, 'There are no images yet'),
            )
          : Center(
              child: showGrid
                  ? buildImageGrid()
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 600),
                            aspectRatio:
                                constraints.maxWidth / constraints.maxHeight,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                          ),
                          items: List.generate(imageTest.length, (index) {
                            return FutureBuilder(
                              future: storage.downloadURL(imageTest[index]),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      // Handle image tap to navigate to individual image screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => IndividualImageScreen(
                                            imageTest[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.network(
                                      snapshot.data!,
                                      fit: BoxFit.contain,
                                    ),
                                  );
                                }
                                if (snapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    !snapshot.hasData) {
                                  return const CircularProgressIndicator();
                                }
                                return Container();
                              },
                            );
                          }),
                        );
                      },
                    ),
            ),
    );
  }

  Widget buildImageGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: imageTest.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Handle grid image tap to navigate to individual image screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => IndividualImageScreen(imageTest[index]),
              ),
            );
          },
          child: FutureBuilder(
            future: storage.downloadURL(imageTest[index]),
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
                return Center(child: CircularProgressIndicator());
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

class IndividualImageScreen extends StatelessWidget {
  final String imagePath;
  final Storage storage = Storage();

  IndividualImageScreen(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(context, 'Image Details'),
      ),
      body: FutureBuilder(
        future: storage.downloadURL(imagePath),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return Center(
              child: Image.network(
                snapshot.data!,
                fit: BoxFit.cover,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
