import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/group_profile_screen.dart';

class groupPromoCard extends StatelessWidget {
  final Group currGroup;

  groupPromoCard(this.currGroup);

  Widget buildListTile(BuildContext context, VoidCallback tapHandler) {
    return Container(
      // height: 40,
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).canvasColor,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        tileColor: Theme.of(context).canvasColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).canvasColor),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(currGroup.groupPhotoUrl),
        ),
        title: buildText(context, currGroup.groupName),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child:
              buildTextSmall(context, '${currGroup.groupUsers.length} members'),
        ),
        onTap: tapHandler,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListTile(context, () {
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
}
