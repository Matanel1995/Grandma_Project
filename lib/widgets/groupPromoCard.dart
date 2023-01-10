import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';
import 'package:google_signin/models/variables.dart';
import 'package:google_signin/screens/group_profile_screen.dart';

class groupPromoCard extends StatelessWidget {
  final Group currGroup;

  groupPromoCard(this.currGroup);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          //const Icon(Icons.looks_one),
          Expanded(
              flex: 1,
              child: Container(
                height: 80,
                width: 1000,
                padding: const EdgeInsets.all(4),
                child: AspectRatio(
                  aspectRatio: 2.62 / 3,
                  child: Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(currGroup.groupPhotoUrl)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                currGroup.groupId == currentUser.currentGroupId
                                    ? Colors.blue
                                    : Colors.transparent,
                            width: 2.2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              stops: const [
                                0.1,
                                0.9
                              ],
                              colors: [
                                Colors.black.withOpacity(.8),
                                Colors.black.withOpacity(.1)
                              ])),
                      child: Align(
                        alignment: const Alignment(-0.8, 0.77),
                        child: Text(
                          currGroup.groupName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return GroupProfileScreen(
            currGroup: currGroup,
          );
        }));
      },
    );
  }
}
