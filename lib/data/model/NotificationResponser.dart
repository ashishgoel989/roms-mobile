class NotificationResponser {
  List<Data>? data;

  NotificationResponser({this.data});

  NotificationResponser.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? username;
  String? from;
  String? message;
  String? type;
  String? eventId;
  Body? body;

  Data(
      {this.username,
        this.from,
        this.message,
        this.type,
        this.eventId,
        this.body});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    from = json['from'];
    message = json['message'];
    type = json['type'];
    eventId = json['eventId'];
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['from'] = this.from;
    data['message'] = this.message;
    data['type'] = this.type;
    data['eventId'] = this.eventId;
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Body {
  List<Null>? devices;
  dynamic profileImage;
  dynamic time;

  Body({this.devices, this.profileImage, this.time});

  Body.fromJson(Map<String, dynamic> json) {
   /* if (json['devices'] != null) {
      devices = <Null>[];
      json['devices'].forEach((v) {
        devices!.add(new Null.fromJson(v));
      });
    }*/
    profileImage = json['profileImage'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   /* if (this.devices != null) {
      data['devices'] = this.devices!.map((v) => v.toJson()).toList();
    }*/
    data['profileImage'] = this.profileImage;
    data['time'] = this.time;
    return data;
  }
}

