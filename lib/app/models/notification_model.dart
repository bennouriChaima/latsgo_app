class NotificationModel {
  String? title;
  String? body;
  String? date;
  List<String>? usersIds;

  NotificationModel({this.body, this.date, this.title, this.usersIds});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    print(json);
    title = json['title'];
    body = json['body'];
    date = json['date'];
    if (json['usersIds'] != null) {
      json['usersIds'].forEach((item) {
        usersIds?.add(item.toString());
      });
    }
  }
}
