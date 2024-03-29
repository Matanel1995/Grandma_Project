import 'package:flutter/material.dart';
import 'package:google_signin/main.dart';
import 'package:google_signin/models/gruopList.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/create_group_screen.dart';
import 'package:google_signin/screens/welcome_screen.dart';

class MyGroupsScreen extends StatelessWidget {
  const MyGroupsScreen({super.key});

  Widget whatToShow(BuildContext context) {
    // if a member has a group so he will see the groups list
    // if he doesn't so he will see a message
    // if(currentUser.currentGroupId != null)
    if (currentUser.groupsList.isEmpty) {
      return Column(
        children: [
          Container(
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
    else {
      return Expanded(
        child: Container(
          child: groupList(context),
        ),
      );
    }
  }

  Widget viewType(BuildContext context) {
    if (!currentUser.isViewer) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
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

  Widget buildListTile(BuildContext context, String title, IconData iconData,
      VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      onTap: tapHandler,
    );
  }

  Widget buildListTileForAdmin(BuildContext context, String title,
      IconData iconData, VoidCallback tapHandler) {
    if (true) {
      return ListTile(
        leading: Icon(
          iconData,
          size: 26,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onTap: tapHandler,
      );
    }
  }

  bottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).backgroundColor,
        context: context,
        builder: (BuildContext c) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildListTile(context, 'Create Group', Icons.create, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) {
                      return const CreateGroupScreen();
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
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: buildTitle(context, 'My Groups'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return const WelcomeScreen();
                },
              ),
            );
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          whatToShow(context),
        ]),
      ),
      floatingActionButton: viewType(context),
    );
  }
}
