import 'package:flutter/material.dart';
import 'package:google_signin/screens/gallery_screen.dart';

import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Grandma Project',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            // to make space
            // const SizedBox(
            //   height: 50,
            // ),
            const Divider(
              height: 50,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(GalleryScreen.routeName);
                },
                child: Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: const Text(
                    'Gallery',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.black),
                  ),
                ),
              ),
            ),
            const Divider(
              height: 50,
            ),
            Center(
              child: Container(
                height: 200,
                width: 300,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                color: Colors.purple,
                child: const Text(
                  'Grandma! \nPress the blue button - Gallery!',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.black),
                ),
              ),
            ),
            const Divider(
              height: 50,
            ),
          ],
        ));
  }
}
