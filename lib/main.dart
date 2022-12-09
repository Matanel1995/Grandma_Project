import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_signin/models/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'dummy_data.dart';
import 'models/activity.dart';
import 'screens/activity_detail_screen.dart';
import 'screens/category_activities_screen.dart';
import 'screens/ideas_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/table_score.dart';
import 'screens/welcome_screen.dart';
import 'widgets/upload_photo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Activity> _availableActivities = DUMMY_ACTIVITIES;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSingInPovider(),
      child: MaterialApp(
        title: 'Grandma Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Color.fromARGB(255, 226, 137, 19),
            canvasColor: const Color.fromRGBO(244, 243, 243, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                subtitle1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ))),
        // home: HomePage(),
        initialRoute: '/', // default is home - '/'
        routes: {
          '/': (ctx) => WelcomeScreen(),
          //  TabsScreen(_favoriteActivities),

          CategoryActivitiessScreen.routeName: (ctx) =>
              CategoryActivitiessScreen(_availableActivities),
          ActivityDetailScreen.routeName: (ctx) => ActivityDetailScreen(),

          TableScore.routeName: (ctx) => TableScore(),
          UploadPhoto.routeName: (ctx) => UploadPhoto(),
          IdeasScreen.routeName: (ctx) => IdeasScreen(),
          GalleryScreen.routeName: (ctx) => GalleryScreen(),
        },
      ),
    );
  }
}
