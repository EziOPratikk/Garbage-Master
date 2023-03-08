import 'package:flutter/material.dart';

import './recent_data.dart';

class TableDataSource extends DataTableSource {
  final List<Map<String, dynamic>> data;

  TableDataSource(this.data);
  // final List<Map<String, dynamic>> _data = List.generate(
  //     RecentData.historyTable.length,
  //     (index) => {
  //           "username": RecentData.historyTable[index].username,
  //           "waste": RecentData.historyTable[index].waste,
  //           "ward": RecentData.historyTable[index].ward,
  //           "date": RecentData.historyTable[index].date,
  //         });

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index]['username'].toString())),
      DataCell(Text(data[index]['waste'].toString())),
      DataCell(Text(data[index]['ward'].toString())),
      DataCell(Text(
        data[index]['date'].toString().substring(1, 11),
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
