import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class GalleryScreen extends StatefulWidget {
  static const routeName = './pictures-screen';

  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Gallery'),
      ),
      // drawer: const MainDrawer(),
      body: Center(
        child: Text(
          'The gallery will be here.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
