import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/screens/welcome_screen.dart';
import 'package:google_signin/storage_service.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = './gallery-screen';
  List<String> imageTest;

  GalleryScreen(this.imageTest, {Key? key}) : super(key: key);

  @override
  State<GalleryScreen> createState() => _GalleryScreenState(imageTest);
}

class _GalleryScreenState extends State<GalleryScreen> {
  final Storage storage = Storage();
  List<String> imageTest;

  _GalleryScreenState(this.imageTest);

  int index = 0;
  bool showGrid = false; // Track whether to show the grid or carousel

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
                  : FutureBuilder(
                      future: storage.downloadURL(imageTest[index]),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
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
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        return Container();
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
        return FutureBuilder(
          future: storage.downloadURL(imageTest[index]),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return GestureDetector(
                onTap: () {
                  // Handle grid image tap to navigate to individual image screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => IndividualImageScreen(snapshot.data!),
                    ),
                  );
                },
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
        );
      },
    );
  }
}

class IndividualImageScreen extends StatelessWidget {
  final String imageUrl;

  const IndividualImageScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(context, 'Image Details'),
      ),
      body: Center(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
