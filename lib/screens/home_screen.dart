import 'package:flutter/material.dart';
import 'package:google_signin/screens/gallery_screen.dart';

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

  Widget promoCard(image) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: const [
                    0.1,
                    0.9
                  ],
                  colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.1)
                  ])),
        ),
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
      height: 200,
      width: 300,
      child: child,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 243, 243, 1),
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
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              InkWell(
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: AssetImage(galleryImage)),
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
                        return GalleryScreen();
                      },
                    ),
                  );
                  Navigator.of(context)
                      .pushReplacementNamed(GalleryScreen.routeName);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildSectionTitle(context, 'Group Members'),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          promoCard(bibiImage),
                          promoCard(eltonImage),
                          promoCard(muskImage),
                          promoCard(trumpImage),
                          promoCard(davidImage),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildSectionTitle(context, 'Messages'),
                    buildContainer(
                      ListView.builder(
                        itemBuilder: (ctx, index) => Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(
                                wishes[index],
                              )),
                        ),
                        itemCount: wishes.length,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text(
  //           'Grandma Project',
  //           style: Theme.of(context).textTheme.titleMedium,
  //         ),
  //       ),
  //       drawer: const MainDrawer(),
  //       body: Column(
  //         children: [
  //           // to make space
  //           // const SizedBox(
  //           //   height: 50,
  //           // ),
  //           Container(
  //             height: 150,
  //             width: 350,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(15),
  //               image: DecorationImage(
  //                   fit: BoxFit.cover, image: AssetImage(elizabethImage)),
  //             ),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(15),
  //                   gradient: LinearGradient(
  //                       begin: Alignment.bottomRight,
  //                       stops: [
  //                         0.3,
  //                         0.9
  //                       ],
  //                       colors: [
  //                         Colors.black.withOpacity(.8),
  //                         Colors.black.withOpacity(.2)
  //                       ])),
  //             ),
  //           ),

  //           const Divider(
  //             height: 50,
  //           ),
  //           Center(
  //             child: InkWell(
  //               onTap: () {
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                     builder: (_) {
  //                       return GalleryScreen();
  //                     },
  //                   ),
  //                 );

  //                 // Navigator.of(context)
  //                 //     .pushReplacementNamed(GalleryScreen.routeName);
  //               },
  //               child: Container(
  //                 height: 300,
  //                 width: 300,
  //                 padding: const EdgeInsets.all(20),
  //                 alignment: Alignment.center,
  //                 color: Colors.lightBlue,
  //                 child: const Text(
  //                   'Gallery',
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.w900,
  //                       fontSize: 30,
  //                       color: Colors.black),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const Divider(
  //             height: 50,
  //           ),
  //           // buildSectionTitle(context, 'Group Members'),

  //           // Center(
  //           //   child: Container(
  //           //     height: 200,
  //           //     width: 300,
  //           //     padding: const EdgeInsets.all(20),
  //           //     alignment: Alignment.center,
  //           //     color: Colors.purple,
  //           //     child: Text(
  //           //       // 'user id - ${displayedMembers[0].name} \n user email - ${displayedMembers[0].email} \n ',

  //           //       'Group Members \n ${displayedMembers[0].name}}',
  //           //       style: TextStyle(
  //           //           fontWeight: FontWeight.w900,
  //           //           fontSize: 20,
  //           //           color: Colors.black),
  //           //     ),
  //           //   ),
  //           // ),
  //           const Divider(
  //             height: 50,
  //           ),
  //         ],
  //       ));
  // }
}
