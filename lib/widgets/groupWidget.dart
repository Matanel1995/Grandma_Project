import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/widgets/groupPromoCard.dart';
import 'package:google_signin/widgets/promoCard.dart';

class groupWidget extends StatelessWidget {
  final String groupName;
  final String groupPhotoUrl;

  groupWidget({required this.groupName, required this.groupPhotoUrl});

  factory groupWidget.fromGroup(Group currGroup) {
    return groupWidget(
      groupName: currGroup.groupName,
      groupPhotoUrl: currGroup.groupPhotoUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    Group currGroup = Group.widgetConstructor(
        groupName: groupName, groupPhotoUrl: groupPhotoUrl);
    return groupPromoCard(currGroup);
  }
}
