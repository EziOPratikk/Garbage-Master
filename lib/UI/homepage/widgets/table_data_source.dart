import 'package:flutter/material.dart';


class TableDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;

  TableDataSource(this.data);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index]['username'].toString())),
      DataCell(Text(data[index]['waste'].toString())),
      DataCell(Text(data[index]['ward'].toString())),
      DataCell(Text(
        data[index]['date'].toString().substring(0, 10),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
