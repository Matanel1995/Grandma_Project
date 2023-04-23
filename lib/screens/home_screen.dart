import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/usersList.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/gallery_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final elizabethImage = 'assets/pictures/queen-elizabeth-removebg.png';
  final galleryImage = 'assets/pictures/gallery.png';
  final bibiImage = 'assets/pictures/bibi.png';
  final davidImage = 'assets/pictures/David.png';
  final eltonImage = 'assets/pictures/elton.png';
  final muskImage = 'assets/pictures/musk.png';
  final trumpImage = 'assets/pictures/trump.png';
  final wishes = [
    'I love you grandma!',
    'Grandma you are the best!',
    'Waiting to spend some time with you!',
    'Grandma thank you very much for the chicken. it was very tasty!',
    'Tomorrow movie time!',
  ];

  List<String> imageList = <String>[];
  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      height: 150,
      width: 300,
      child: child,
    );
  }

  void getImages() async {
    final firebase_storage.ListResult result = await firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(currentUser.currentGroupId)
        .listAll();
    for (var i = 0; i < result.items.length; i++) {
      imageList.add(result.items[i].name);
    }
  }

  Future<String> testFunction() async {
    return "";
  }

  Widget whatToShow() {
    // if there are members and there is a group return list of members and messages box
    // else write a message and send the user to build a group or join
    if (currentUser.groupsList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildTitle(context, 'Group Members'),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            child: UsersList(),
          ),
        ],
      );
    }
    return Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).cardColor, width: 6),
            borderRadius: BorderRadius.all(Radius.circular(35))),
        child: RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 26, color: Colors.black),
            children: [
              TextSpan(
                text: 'You dont have any groups yet. \n\nPress the ',
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.menu,
                    size: 30,
                  ),
                ),
              ),
              TextSpan(
                text: ' icon. \n\nNavigate to: \n\n',
              ),
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.group,
                    size: 30,
                  ),
                ),
              ),
              TextSpan(
                text: ' My Groups. \n\nFollow the instructions.',
              ),
            ],
          ),
        )

        // const Text(
        //   'You dont have any groups yet. \nPress the hamburger button on the top left corner and press the - My Groups tab and follow the instructions.',
        //   style: TextStyle(fontSize: 30),
        // ),
        );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getImages();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: buildTitle(context, 'Home'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      drawer: const MainDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: InkWell(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.fill, image: AssetImage(galleryImage)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            stops: const [
                              0.3,
                              0.9
                            ],
                            colors: [
                              Colors.black.withOpacity(.8),
                              Colors.black.withOpacity(.2)
                            ]),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: buildTitle(context, 'To The Gallery'),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          getImages();
                          return GalleryScreen(imageList);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: whatToShow(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
