import 'package:flutter/material.dart';
import 'package:google_signin/models/Group.dart';

class groupPromoCard extends StatelessWidget {
  final Group currGroup;

  groupPromoCard(this.currGroup);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 1000,
      padding: const EdgeInsets.all(4),
      child: AspectRatio(
        aspectRatio: 2.62 / 3,
        child: Container(
          margin: EdgeInsets.only(right: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(currGroup.groupPhotoUrl)),
          ),
          child: Container(
            child: Align(
              alignment: Alignment(-0.8, 0.77),
              child: Text(
                currGroup.groupName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
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
          ),
        ),
      ),
    );
    ;
  }
}
