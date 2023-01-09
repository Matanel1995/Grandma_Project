import 'package:flutter/material.dart';
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

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

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
    // print(imageList);
    // print(imageList.length);
  }

  Widget whatToShow() {
    // if there are members and there is a group return list of members and messages box
    // else write a message and send the user to build a group or join
    if (true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildSectionTitle(context, 'Group Members'),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            child: UsersList(),
          ),
          // buildSectionTitle(context, 'Messages'),
          // Center(
          //   child: buildContainer(
          //     ListView.builder(
          //       itemBuilder: (ctx, index) => Card(
          //         color: Theme.of(context).accentColor,
          //         child: Padding(
          //             padding: const EdgeInsets.symmetric(
          //                 vertical: 5, horizontal: 10),
          //             child: Text(
          //               wishes[index],
          //             )),
          //       ),
          //       itemCount: wishes.length,
          //     ),
          //   ),
          // ),
          //     GridView(
          //   padding: const EdgeInsets.all(25),
          //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          //     maxCrossAxisExtent: 200,
          //     childAspectRatio: 3 / 2,
          //     crossAxisSpacing: 20,
          //     mainAxisSpacing: 20,
          //   ),

          //   children: currentUser.photoUrl,
          // )
          ElevatedButton(
              onPressed: () async {
                currentUser.getUsersUsingServer([currentUser.id]);
              },
              child: Text('Test'))
        ],
      );
    }
    return Container(
        margin: const EdgeInsets.all(30),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 6),
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
      backgroundColor: const Color(0x00effffd),
      appBar: AppBar(
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        backgroundColor: Colors.blueGrey,
        brightness: Brightness.light,
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
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'To The Gallery',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
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
