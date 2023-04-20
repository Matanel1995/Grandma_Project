import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/group_profile_screen.dart';

class groupPromoCard extends StatelessWidget {
  final Group currGroup;

  groupPromoCard(this.currGroup);

  Widget buildListTile(VoidCallback tapHandler) {
    return Container(
      // height: 40,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.brown[100],
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        tileColor: Colors.brown[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(currGroup.groupPhotoUrl),
        ),
        title: Text(
          currGroup.groupName,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            // color: Colors.grey.shade800,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${currGroup.groupUsers.length} members',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        onTap: tapHandler,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTile(() {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return GroupProfileScreen(
                  currGroup: currGroup,
                );
              },
            ),
          );
        })
      ],
    );
  }

  // Widget build(BuildContext context) {
  //   return InkWell(
  //     child: Row(
  //       children: [
  //         const Icon(Icons.looks_one),
  //         Expanded(
  //             flex: 1,
  //             child: Container(
  //               height: 200,
  //               width: 1000,
  //               padding: const EdgeInsets.all(4),
  //               child: AspectRatio(
  //                 aspectRatio: 2.62 / 3,
  //                 child: Container(
  //                   margin: const EdgeInsets.only(right: 15.0),
  //                   decoration: BoxDecoration(
  //                     borderRadius: BorderRadius.circular(20),
  //                     image: DecorationImage(
  //                         fit: BoxFit.cover,
  //                         image: NetworkImage(currGroup.groupPhotoUrl)),
  //                   ),
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(20),
  //                         gradient: LinearGradient(
  //                             begin: Alignment.bottomRight,
  //                             stops: const [
  //                               0.1,
  //                               0.9
  //                             ],
  //                             colors: [
  //                               Colors.black.withOpacity(.8),
  //                               Colors.black.withOpacity(.1)
  //                             ])),
  //                     child: Align(
  //                       alignment: const Alignment(-0.8, 0.77),
  //                       child: Text(
  //                         currGroup.groupName,
  //                         style: const TextStyle(
  //                           fontSize: 20,
  //                           fontWeight: FontWeight.w500,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             )),
  //       ],
  //     ),
  //     onTap: () {
  //       Navigator.of(context).push(MaterialPageRoute(builder: (_) {
  //         return GroupProfileScreen(
  //           currGroup: currGroup,
  //         );
  //       }));
  //     },
  //   );
  // }
}
