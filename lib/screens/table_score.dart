import 'package:flutter/material.dart';

class TableScore extends StatefulWidget {
  static const routeName = './table-score';
  const TableScore({super.key});

  @override
  State<TableScore> createState() => _FiltersScreenState();
}

Widget buildText(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText2,
  );
}

Widget buildTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.bodyText1,
  );
}

class _FiltersScreenState extends State<TableScore> {
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: buildTitle(context, 'The Table Score'),
        ),
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
        ));
  }
}
