import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class TableScore extends StatefulWidget {
  static const routeName = './table-score';
  const TableScore({super.key});

  @override
  State<TableScore> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<TableScore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Score Table'),
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Text(
          'The score table will be here.',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
