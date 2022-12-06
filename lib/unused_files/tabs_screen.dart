// import 'package:flutter/material.dart';
// import 'package:meals_project/screens/ideas_screen.dart';
// import 'package:meals_project/screens/gallery_screen.dart';
// import 'package:meals_project/widgets/main_drawer.dart';
// import 'package:meals_project/widgets/upload_photo.dart';
// import '../models/activity.dart';

// class TabsScreen extends StatefulWidget {
//   final List<Activity> favoriteActivities;

//   TabsScreen(this.favoriteActivities);

//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }

// class _TabsScreenState extends State<TabsScreen> {
//   late List<Map<String, Object>> _pages;
//   int _selectedPageIndex = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     _pages = [
//       {'page': IdeasScreen(), 'title': 'Home'},
//       {
//         'page': GalleryScreen(widget.favoriteActivities),
//         'title': 'Your Gallery',
//       },
//       // {'page': UploadPhoto(), 'title': 'Upload Photo'},
//     ];
//     super.initState();
//   }

//   void _selectPage(int index) {
//     setState(() {
//       _selectedPageIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_pages[_selectedPageIndex]['title'] as String),
//       ),
//       drawer: const MainDrawer(),
//       body: _pages[_selectedPageIndex]['page'] as Widget,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: _selectPage,
//         backgroundColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Colors.white,
//         selectedItemColor: Theme.of(context).accentColor,
//         currentIndex: _selectedPageIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.house),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.camera),
//             label: 'Gallery',
//           ),
//           // BottomNavigationBarItem(
//           //   icon: Icon(Icons.add),
//           //   label: 'Upload Photo',
//           // ),
//         ],
//       ),
//     );
//   }
// }
