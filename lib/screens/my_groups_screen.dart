import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/gruopList.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/add_user_screen.dart';
import 'package:google_signin/screens/create_group_screen.dart';
import 'package:google_signin/screens/kick_user_screen.dart';
import 'package:google_signin/screens/leave_group_screen.dart';

import '../widgets/groupPromoCard.dart';

class MyGroupsScreen extends StatelessWidget {
  const MyGroupsScreen({super.key});

  Widget whatToShow() {
    // if a member has a group so he will see the groups list
    // if he doesn't so he will see a message
    // if(currentUser.currentGroupId != null)
    if (currentUser.groupsList.isEmpty) {
      return Column(
        children: [
          Container(
            // height: 300,
            // width: double.infinity,
            child:
                Image.asset('assets/pictures/You dont have any groups yet.png'),
          ),
          const Divider(
            height: 20,
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              'https://s.yimg.com/ny/api/res/1.2/RUC3Kkg.G5ThONyCGMAaaQ--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MA--/https://s.yimg.com/os/creatr-uploaded-images/2021-04/d2b04c70-9d17-11eb-8c72-c53d4ff70eee',
              fit: BoxFit.cover,
            ),
          )
        ],
      );
    }
    // return GroupList
    // I think it will be good if Matanel can do here the same he did with usersList , just with a GridView
    else {
      print(currentUser.currentGroupId);
      return Expanded(
        child: Container(
          child: groupList(),
        ),
      );
    }
  }

  void nada() {}

  Widget viewType(BuildContext context) {
    if (!currentUser.isViewer) {
      return FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          bottomSheet(context);
        },
      );
    }
    return Container();
  }

  Widget buildListTile(
      String title, IconData iconData, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  Widget buildListTileForAdmin(
      String title, IconData iconData, VoidCallback tapHandler) {
    //if(currentUser.isAdmin)
    if (true) {
      return ListTile(
        leading: Icon(
          iconData,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: tapHandler,
      );
    }
  }

  bottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Color.fromARGB(255, 251, 247, 247),
        context: context,
        builder: (BuildContext c) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildListTile('Create Group', Icons.create, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return CreateGroupScreen();
                    },
                  ),
                );
              }),
              buildListTile('Leave Group', Icons.exit_to_app, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return LeaveGroupScreen();
                    },
                  ),
                );
              }),
              buildListTileForAdmin('Add User', Icons.add_road, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return AddUserScreen();
                    },
                  ),
                );
              }),
              buildListTileForAdmin('Kick User', Icons.no_accounts, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return kickUserScreen();
                    },
                  ),
                );
              }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Groups',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          whatToShow(),
        ]),
      ),
      floatingActionButton: viewType(context),
    );
  }
}
