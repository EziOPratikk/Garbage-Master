import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/history_table.dart';
import '../../../models/api.services.dart';
import '../../progress_indicator_widget.dart';

class RecentData extends StatelessWidget {
  const RecentData({super.key});

  static List<HistoryTable> historyTable = [];

  Future<List<HistoryTable>> gethistoryData() async {
    final currentUser = await APIServices.historyTable({
      'username': await SharedPreferences.getInstance()
          .then((value) => value.getString('username') ?? 'no username found'),
    });

    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    if (historyTable != null) {
      historyTable.clear();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: gethistoryData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: PaginatedDataTable(
                    header: const Text(
                      'Recent Waste Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    columnSpacing: MediaQuery.of(context).size.width * 0.1,
                    rowsPerPage: 10,
                    source: TableData(),
                    arrowHeadColor: Theme.of(context).primaryColor,
                    columns: const [
                      DataColumn(label: Center(child: Text('Username'))),
                      DataColumn(label: Center(child: Text('Waste'))),
                      DataColumn(label: Center(child: Text('Ward'))),
                      DataColumn(label: Center(child: Text('Last Date'))),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          'assets/images/recycle-bin.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'No data available',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

class TableData extends DataTableSource {
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
