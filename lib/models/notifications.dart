class NotificationModel {
  late int? id;
  late String title;
  late String body;
  late DateTime date;
  late String messageId;

  NotificationModel({
    this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.messageId,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    date = DateTime.parse(json['date']);
    messageId = json['messageId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['date'] = date.toString();
    data['messageId'] = messageId;
    return data;
  }
}
