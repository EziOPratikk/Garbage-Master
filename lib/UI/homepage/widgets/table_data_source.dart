import 'package:flutter/material.dart';

import './recent_data.dart';

class TableDataSource extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      RecentData.historyTable.length,
      (index) => {
            "username": RecentData.historyTable[index].username,
            "waste": RecentData.historyTable[index].waste,
            "ward": RecentData.historyTable[index].ward,
            "date": RecentData.historyTable[index].date,
          });
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index]['username'].toString())),
      DataCell(Text(_data[index]['waste'].toString())),
      DataCell(Text(_data[index]['ward'].toString())),
      DataCell(Text(
        _data[index]['date'].toString().substring(1, 11),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;
}
