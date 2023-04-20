import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/widgets/UserWidget.dart';
import 'package:google_signin/widgets/promoCard.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

// class UsersList extends StatelessWidget {
//   UsersList({super.key});

//   final channel = WebSocketChannel.connect(Uri.parse(
//       'ws://localhost:8080/group/getAllMembers/w4JQXtPkC8X1VtxA76bA'));

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       // stream: FirebaseFirestore.instance.collection('User').snapshots(),
//       stream: channel.stream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         } else if (snapshot.connectionState == ConnectionState.active ||
//             snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.hasError) {
//             print("ERROR!!!:" + snapshot.error.toString());
//             return Text('Error occurred: ${snapshot.error}');
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 //creating a map to store user details
//                 Map<String, dynamic> userDetails =
//                     snapshot.data!.docs[index].data();
//                 print(userDetails['groupList'].toString());
//                 if (userDetails['groupList']
//                         .toString()
//                         .contains(currentUser.currentGroupId) &&
//                     currentUser.currentGroupId != '0') {
//                   MyUser tempUser = MyUser.fromFirestore(userDetails);
//                   return UserWidget.fromMyUser(tempUser);
//                 } else {
//                   return Container();
//                 }
//                 //creating user object with firestoreBuilder
//               },
//             );
//           } else {
//             return const Text('Empty data');
//           }
//         } else {
//           return Text('state: ${snapshot.connectionState}');
//         }
//       },
//     );
//   }
// }

import 'package:socket_io_client/socket_io_client.dart' as IO;

class UsersList extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<UsersList> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    print("gettiing data from server!");
    socket = IO.io('ws://localhost:8080');
    print("printing socket: ${socket.toString()}");
    socket.on('data', (data) {
      print('Received data from server: $data');
      // Do something with the data here
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('User').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('Error occurred');
          } else if (snapshot.hasData) {
            // return ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index) {
            //     //creating a map to store user details
            //     Map<String, dynamic> userDetails =
            //         snapshot.data!.docs[index].data();
            //     //creating user object with firestoreBuilder
            //     MyUser tempUser = MyUser.fromFirestore(userDetails);
            //     return UserWidget.fromMyUser(tempUser);
            //   },
            // );
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                //creating a map to store user details
                Map<String, dynamic> userDetails =
                    snapshot.data!.docs[index].data();
                print(userDetails['groupList'].toString());
                if (userDetails['groupList']
                        .toString()
                        .contains(currentUser.currentGroupId) &&
                    currentUser.currentGroupId != '0') {
                  MyUser tempUser = MyUser.fromFirestore(userDetails);
                  return UserWidget.fromMyUser(tempUser);
                } else {
                  return Container();
                }
                //creating user object with firestoreBuilder
              },
            );
          } else {
            return const Text('Empty data');
          }
        } else {
          return Text('state: ${snapshot.connectionState}');
        }
      },
    );
  }
}
