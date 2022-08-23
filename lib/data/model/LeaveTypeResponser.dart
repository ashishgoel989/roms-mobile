class LeaveTypeResponser {
  List<Data>? data;

  LeaveTypeResponser({this.data});

  LeaveTypeResponser.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? createDate;
  Null? createBy;
  Null? lastUpdateDate;
  Null? updateBy;
  String? name;
  String? leaveDescription;
  int? numberDaysAllowed;

  Data(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.name,
        this.leaveDescription,
        this.numberDaysAllowed});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'];
    name = json['name'];
    leaveDescription = json['leaveDescription'];
    numberDaysAllowed = json['numberDaysAllowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['updateBy'] = this.updateBy;
    data['name'] = this.name;
    data['leaveDescription'] = this.leaveDescription;
    data['numberDaysAllowed'] = this.numberDaysAllowed;
    return data;
  }
}

