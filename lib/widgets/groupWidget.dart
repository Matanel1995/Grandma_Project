import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/user.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/widgets/groupPromoCard.dart';
import 'package:google_signin/widgets/promoCard.dart';

class groupWidget extends StatelessWidget {
  final String groupName;
  final String groupPhotoUrl;
  final String groupId;
  final Map<String, dynamic> groupUsers;
  final String groupManagerId;

  groupWidget({
    required this.groupName,
    required this.groupPhotoUrl,
    required this.groupId,
    required this.groupManagerId,
    required this.groupUsers,
  });

  factory groupWidget.fromGroup(Group currGroup) {
    return groupWidget(
      groupName: currGroup.groupName,
      groupPhotoUrl: currGroup.groupPhotoUrl,
      groupId: currGroup.groupId,
      groupManagerId: currGroup.groupManagerId,
      groupUsers: currGroup.groupUsers,
    );
  }

  @override
  Widget build(BuildContext context) {
    Group currGroup = Group.widgetConstructor(
      groupName: groupName,
      groupPhotoUrl: groupPhotoUrl,
      groupId: groupId,
      groupManagerId: groupManagerId,
      groupUsers: groupUsers,
    );
    return groupPromoCard(currGroup);
  }
}
