import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/history_table.dart';
import '../../../models/api.services.dart';
import './table_data_source.dart';
import '../../progress_indicator_widget.dart';

class RecentData extends StatelessWidget {
  const RecentData({super.key});

  static List<HistoryTable> historyTable = [];

  Future<List<HistoryTable>> getHistoryData() async {
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
          title: const Text('Waste Details'),
          centerTitle: true,
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
            future: getHistoryData(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return historyTable[0].username.isEmpty
                    ? Center(
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
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : SingleChildScrollView(
                        child: PaginatedDataTable(
                          header: const Text(
                            'Recent Waste Data',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          columnSpacing:
                              MediaQuery.of(context).size.width * 0.1,
                          rowsPerPage: 10,
                          source: TableDataSource(historyTable
                              .map((e) => {
                                    "username": e.username,
                                    "waste": e.waste,
                                    "ward": e.ward,
                                    "date": e.date,
                                  })
                              .toList()),
                          arrowHeadColor: Theme.of(context).primaryColor,
                          columns: const [
                            DataColumn(label: Center(child: Text('Username'))),
                            DataColumn(label: Center(child: Text('Waste'))),
                            DataColumn(label: Center(child: Text('Ward'))),
                            DataColumn(label: Center(child: Text('Last Date'))),
                          ],
                        ),
                      );
                // return ListView.builder(
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(historyTable[index].username),
                //       leading: Text('${historyTable[index].ward}'),
                //     );
                //   },
                //   itemCount: historyTable.length,
                // );
              } else {
                return const ProgressIndicatorWidget();
              }
            }),
          ),
        ),
      ),
    );
  }
}
