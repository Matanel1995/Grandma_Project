// import 'package:flutter/material.dart';
// import '../models/activity.dart';
// import '../widgets/activity_item.dart';

// class GalleryScreen extends StatelessWidget {
//   final List<Activity> favoriteActivities;

//   GalleryScreen(this.favoriteActivities);

//   @override
//   Widget build(BuildContext context) {
//     if (favoriteActivities.isEmpty) {
//       return Center(
//         child: Text(
//           'You have no photos yet - start adding some!',
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       );
//     } else {
//       return ListView.builder(
//         itemBuilder: (ctx, index) {
//           return ActivityItem(
//             id: favoriteActivities[index].id,
//             title: favoriteActivities[index].title,
//             imageUrl: favoriteActivities[index].imageUrl,
//             complexity: favoriteActivities[index].urgency,
//             duration: favoriteActivities[index].duration,
//             score: favoriteActivities[index].score,
//           );
//         },
//         itemCount: favoriteActivities.length,
//       );
//     }
//   }
// }
