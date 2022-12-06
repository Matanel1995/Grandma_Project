// import 'package:flutter/material.dart';

// class UploadPhoto extends StatelessWidget {
//   static const routeName = './upload_photo';
//   const UploadPhoto({super.key});

//   Widget buildListTile(
//       String title, IconData iconData, VoidCallback tapHandler) {
//     return ListTile(
//       leading: Icon(
//         iconData,
//         size: 26,
//       ),
//       title: Text(
//         title,
//         style: const TextStyle(
//           fontFamily: 'RobotoCondensed',
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       onTap: tapHandler,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text('The Score Table'),
//       // ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 120,
//             width: double.infinity,
//             padding: const EdgeInsets.all(20),
//             alignment: Alignment.centerLeft,
//             color: Theme.of(context).accentColor,
//             child: Text(
//               'Upload a photo',
//               style: TextStyle(
//                   fontWeight: FontWeight.w900,
//                   fontSize: 30,
//                   color: Theme.of(context).primaryColor),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           buildListTile('Camera', Icons.add_a_photo, () {
//             // Navigator.of(context).pushReplacementNamed('/');
//           }),
//           buildListTile('Photo Library', Icons.file_upload, () {
//             // Navigator.of(context).pushReplacementNamed(TableScore.routeName);
//           }),
//           buildListTile('Back Home', Icons.house, () {
//             Navigator.of(context).pushReplacementNamed('/');
//           }),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class UploadPhoto extends StatefulWidget {
  static const routeName = './upload_photo';
  const UploadPhoto({super.key});

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Upload Photo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            const Divider(
              height: 50,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacementNamed(PicturesScreen.routeName);
                },
                child: Container(
                  height: 300,
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.lightBlue,
                  child: const Text(
                    'Camera',
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
              child: InkWell(
                onTap: () {
                  // Navigator.of(context)
                  //     .pushReplacementNamed(PicturesScreen.routeName);
                },
                child: Container(
                  height: 200,
                  width: 300,
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  color: Colors.purple,
                  child: const Text(
                    'Photo Library',
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
          ],
        ));
  }
}
