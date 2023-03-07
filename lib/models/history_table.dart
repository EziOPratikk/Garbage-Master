import 'dart:convert';

List<HistoryTable> historyTableFromMap(String str) => List<HistoryTable>.from(
      json.decode(str).map(
            (e) => HistoryTable.fromMap(e),
          ),
    );

String historyTableToMap(List<HistoryTable> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (e) => e.toMap(),
        ),
      ),
    );

class HistoryTable {
  late String username;
  late String waste;
  late int ward;
  late String date;

  HistoryTable(
    this.username,
    this.waste,
    this.ward,
    this.date,
  );

  HistoryTable.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    waste = map['waste'];
    ward = map['ward'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'waste': waste,
      'ward': ward,
      'date': date,
    };
  }
}
