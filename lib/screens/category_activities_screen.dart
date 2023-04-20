import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../widgets/activity_item.dart';

class CategoryActivitiessScreen extends StatefulWidget {
  static const routeName = '/category-activities';

  final List<Activity> availableActivities;

  CategoryActivitiessScreen(this.availableActivities);
  @override
  State<CategoryActivitiessScreen> createState() =>
      _CategoryActivitiessScreen();
}

class _CategoryActivitiessScreen extends State<CategoryActivitiessScreen> {
  late String categoryTitle;
  late List<Activity> displayedActivities;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      displayedActivities = widget.availableActivities.where((activity) {
        return activity.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return ActivityItem(
            id: displayedActivities[index].id,
            title: displayedActivities[index].title,
            imageUrl: displayedActivities[index].imageUrl,
            complexity: displayedActivities[index].urgency,
            duration: displayedActivities[index].duration,
            score: displayedActivities[index].score,
          );
        },
        itemCount: displayedActivities.length,
      ),
    );
  }
}
