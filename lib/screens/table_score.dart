import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class TableScore extends StatefulWidget {
  static const routeName = './table-score';
  const TableScore({super.key});

  @override
  State<TableScore> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<TableScore> {
//   onSortColum(int columnIndex, bool ascending) {
//   if (columnIndex == 0) {
//     if (ascending) {
//       yourDataList.sort((a, b) => a['name'].compareTo(b['name']));
//     } else {
//       yourDataList.sort((a, b) => b['name'].compareTo(a['name']));
//     }
//   }
// }

  bool sort = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'The Table Score',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        // drawer: const MainDrawer(),
        body: DataTable(
          columnSpacing: 35,
          sortColumnIndex: 4,
          sortAscending: true,
          columns: const [
            DataColumn(label: Text('Id'), numeric: true),
            DataColumn(label: Text('Name'), numeric: false),
            DataColumn(label: Text('Photos'), numeric: true),
            DataColumn(label: Text('Activities'), numeric: true),
            DataColumn(
              label: Text('Score'),
              numeric: true,
              // onSort: (columnIndex, ascending) {
              //   setState(() {
              //     sort = !sort;
              //   });
              //   onSortColum(columnIndex, ascending);
              // },
            )
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('1')),
              DataCell(Text('Adiel')),
              DataCell(Text('3')),
              DataCell(Text('0')),
              DataCell(Text('9')),
            ]),
            DataRow(cells: [
              DataCell(Text('2')),
              DataCell(Text('Matanel')),
              DataCell(Text('0')),
              DataCell(Text('4')),
              DataCell(Text('20')),
            ]),
            DataRow(cells: [
              DataCell(Text('3')),
              DataCell(Text('Norton')),
              DataCell(Text('4')),
              DataCell(Text('1')),
              DataCell(Text('17')),
            ]),
          ],
        )
        // Center(
        //   child: Text(
        //     'The score table will be here.',
        //     style: Theme.of(context).textTheme.titleMedium,
        //   ),
        // ),
        );
  }
}
