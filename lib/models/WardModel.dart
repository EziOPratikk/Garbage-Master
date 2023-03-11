class WardModel {
  final String wardName;
  final int average;

  WardModel({required this.wardName, required this.average});

  WardModel.fromMap(Map<String, dynamic> map)
      : wardName = map['wardName'],
        average = map['average'];

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wardName'] = wardName;
    data['average'] = average;
    return data;
  }
}
