import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class PicturesScreen extends StatefulWidget {
  static const routeName = './pictures-screen';

  const PicturesScreen({super.key});

  @override
  State<PicturesScreen> createState() => _PicturesScreenState();
}

class _PicturesScreenState extends State<PicturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Gallery'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Text(
          'The gallery will be here.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
