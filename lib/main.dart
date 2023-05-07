import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_signin/models/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'dummy_data.dart';
import 'models/activity.dart';
import 'screens/activity_detail_screen.dart';
import 'screens/category_activities_screen.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

Widget buildText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText2,
  );
}

Widget buildTextSmall(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.subtitle1,
  );
}

Widget buildTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText1,
  );
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
      create: (context) => GoogleSingInPovider(context),
      child: MaterialApp(
        title: 'Grandma Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // primaryColor: Colors.brown,
            // Option 1
            // scaffoldBackgroundColor: Color(0xff264653),
            // cardColor: Color(0xffe9c46a),
            // backgroundColor: Color(0xff2a9d8f),
            // canvasColor: Color(0xffe76f51),
            // focusColor: Colors.white,

            // Option 2
            // scaffoldBackgroundColor: Color(0xff006d77),
            // cardColor: Color(0xffffddd2),
            // backgroundColor: Color(0xff83c5be),
            // canvasColor: Color(0xffe29578),
            // focusColor: Color(0xffedf6f9),

            // Option 3
            scaffoldBackgroundColor: Color(0xff1d3557),
            cardColor: Color(0xffe63946),
            backgroundColor: Color(0xffa8dadc),
            canvasColor: Color(0xff457b9d),
            focusColor: Color(0xfff1faee),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                  bodyText1: const TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                    color:
                        // Option 2
                        Color(0xffedf6f9),
                    // Option 3
                    // Color(0xfff1faee)
                  ),
                  bodyText2: const TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  subtitle1: const TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  // subtitle2: const TextStyle(
                  //   fontFamily: 'RobotoCondensed',
                  //   fontSize: 15,
                  //   fontWeight: FontWeight.w500,
                  //   color: Colors.black,
                  // ),
                )),
        // home: HomePage(),
        initialRoute: '/', // default is home - '/'
        routes: {
          '/': (ctx) => WelcomeScreen(),
          CategoryActivitiessScreen.routeName: (ctx) =>
              CategoryActivitiessScreen(_availableActivities),
          ActivityDetailScreen.routeName: (ctx) => ActivityDetailScreen(),
        },
      ),
    );
  }
}
