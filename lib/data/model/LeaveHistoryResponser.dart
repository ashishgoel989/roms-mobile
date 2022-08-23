class LeaveHistoryResponser {
  int? totalElement;
  int? numberOfelement;
  List<DataHistory>? data;
  int? currentPageNmber;
  int? totalPage;

  LeaveHistoryResponser(
      {this.totalElement,
        this.numberOfelement,
        this.data,
        this.currentPageNmber,
        this.totalPage});

  LeaveHistoryResponser.fromJson(Map<String, dynamic> json) {
    totalElement = json['totalElement'];
    numberOfelement = json['numberOfelement'];
    if (json['data'] != null) {
      data = <DataHistory>[];
      json['data'].forEach((v) {
        data!.add(new DataHistory.fromJson(v));
      });
    }
    currentPageNmber = json['currentPageNmber'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalElement'] = this.totalElement;
    data['numberOfelement'] = this.numberOfelement;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['currentPageNmber'] = this.currentPageNmber;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class DataHistory {
  String? id;
  String? createDate;
  CreateBy? createBy;
  String? lastUpdateDate;
  CreateBy? updateBy;
  LeaveType? leaveType;
  String? applyDate;
  int? leaveStatus;
  String? startDateTime;
  String? endDateTime;
  dynamic? strStartDateTime;
  dynamic? strEndDateTime;
  dynamic? totalHour;
  dynamic? totalDay;
  String? leaveReason;
  String? reviewerRemark;
  String? dateOfApproval;
  EmployeId? employe;
  EmployeId? approver;

  DataHistory(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.leaveType,
        this.applyDate,
        this.leaveStatus,
        this.startDateTime,
        this.endDateTime,
        this.strStartDateTime,
        this.strEndDateTime,
        this.totalHour,
        this.totalDay,
        this.leaveReason,
        this.reviewerRemark,
        this.dateOfApproval,
        this.employe,
        this.approver});

  DataHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'] != null
        ? new CreateBy.fromJson(json['createBy'])
        : null;
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'] != null
        ? new CreateBy.fromJson(json['updateBy'])
        : null;
    leaveType = json['leaveType'] != null
        ? new LeaveType.fromJson(json['leaveType'])
        : null;
    applyDate = json['applyDate'];
    leaveStatus = json['leaveStatus'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    strStartDateTime = json['strStartDateTime'];
    strEndDateTime = json['strEndDateTime'];
    totalHour = json['totalHour'];
    totalDay = json['totalDay'];
    leaveReason = json['leaveReason'];
    reviewerRemark = json['reviewerRemark'];
    dateOfApproval = json['dateOfApproval'];
    employe = json['employe'] != null
        ? new EmployeId.fromJson(json['employe'])
        : null;
    approver = json['approver'] != null
        ? new EmployeId.fromJson(json['approver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    if (this.createBy != null) {
      data['createBy'] = this.createBy!.toJson();
    }
    data['lastUpdateDate'] = this.lastUpdateDate;
    if (this.updateBy != null) {
      data['updateBy'] = this.updateBy!.toJson();
    }
    if (this.leaveType != null) {
      data['leaveType'] = this.leaveType!.toJson();
    }
    data['applyDate'] = this.applyDate;
    data['leaveStatus'] = this.leaveStatus;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['strStartDateTime'] = this.strStartDateTime;
    data['strEndDateTime'] = this.strEndDateTime;
    data['totalHour'] = this.totalHour;
    data['totalDay'] = this.totalDay;
    data['leaveReason'] = this.leaveReason;
    data['reviewerRemark'] = this.reviewerRemark;
    data['dateOfApproval'] = this.dateOfApproval;
    if (this.employe != null) {
      data['employe'] = this.employe!.toJson();
    }
    if (this.approver != null) {
      data['approver'] = this.approver!.toJson();
    }
    return data;
  }
}

class CreateBy {
  String? id;
  String? createDate;
  CreateBy? createBy;
  dynamic? lastUpdateDate;
  dynamic? updateBy;
  String? userId;
  String? authenticatonType;
  String? apppassword;
  EmployeId? employeId;
  bool? disableFlag;
  dynamic? endDate;
  bool? passwordExpiryFlag;
  dynamic? role;
  bool? enabled;
  String? username;
  bool? accountNonExpired;
  bool? credentialsNonExpired;
  bool? accountNonLocked;
  String? password;
  dynamic? authorities;

  CreateBy(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.userId,
        this.authenticatonType,
        this.apppassword,
        this.employeId,
        this.disableFlag,
        this.endDate,
        this.passwordExpiryFlag,
        this.role,
        this.enabled,
        this.username,
        this.accountNonExpired,
        this.credentialsNonExpired,
        this.accountNonLocked,
        this.password,
        this.authorities});

  CreateBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'] != null
        ? new CreateBy.fromJson(json['createBy'])
        : null;
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'];
    userId = json['userId'];
    authenticatonType = json['authenticatonType'];
    apppassword = json['apppassword'];
    employeId = json['employeId'] != null
        ? new EmployeId.fromJson(json['employeId'])
        : null;
    disableFlag = json['disableFlag'];
    endDate = json['endDate'];
    passwordExpiryFlag = json['passwordExpiryFlag'];
    role = json['role'];
    enabled = json['enabled'];
    username = json['username'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    password = json['password'];
    authorities = json['authorities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    if (this.createBy != null) {
      data['createBy'] = this.createBy!.toJson();
    }
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['updateBy'] = this.updateBy;
    data['userId'] = this.userId;
    data['authenticatonType'] = this.authenticatonType;
    data['apppassword'] = this.apppassword;
    if (this.employeId != null) {
      data['employeId'] = this.employeId!.toJson();
    }
    data['disableFlag'] = this.disableFlag;
    data['endDate'] = this.endDate;
    data['passwordExpiryFlag'] = this.passwordExpiryFlag;
    data['role'] = this.role;
    data['enabled'] = this.enabled;
    data['username'] = this.username;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['password'] = this.password;
    data['authorities'] = this.authorities;
    return data;
  }
}

class CreateBy1 {
  String? id;
  String? createDate;
  dynamic? createBy;
  dynamic? lastUpdateDate;
  dynamic? updateBy;
  String? userId;
  String? authenticatonType;
  String? apppassword;
  EmployeId? employeId;
  bool? disableFlag;
  dynamic? endDate;
  bool? passwordExpiryFlag;
  dynamic? role;
  bool? enabled;
  String? username;
  bool? accountNonExpired;
  bool? credentialsNonExpired;
  bool? accountNonLocked;
  String? password;
  dynamic? authorities;

  CreateBy1(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.userId,
        this.authenticatonType,
        this.apppassword,
        this.employeId,
        this.disableFlag,
        this.endDate,
        this.passwordExpiryFlag,
        this.role,
        this.enabled,
        this.username,
        this.accountNonExpired,
        this.credentialsNonExpired,
        this.accountNonLocked,
        this.password,
        this.authorities});

  CreateBy1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'];
    userId = json['userId'];
    authenticatonType = json['authenticatonType'];
    apppassword = json['apppassword'];
    employeId = json['employeId'] != null
        ? new EmployeId.fromJson(json['employeId'])
        : null;
    disableFlag = json['disableFlag'];
    endDate = json['endDate'];
    passwordExpiryFlag = json['passwordExpiryFlag'];
    role = json['role'];
    enabled = json['enabled'];
    username = json['username'];
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    password = json['password'];
    authorities = json['authorities'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['updateBy'] = this.updateBy;
    data['userId'] = this.userId;
    data['authenticatonType'] = this.authenticatonType;
    data['apppassword'] = this.apppassword;
    if (this.employeId != null) {
      data['employeId'] = this.employeId!.toJson();
    }
    data['disableFlag'] = this.disableFlag;
    data['endDate'] = this.endDate;
    data['passwordExpiryFlag'] = this.passwordExpiryFlag;
    data['role'] = this.role;
    data['enabled'] = this.enabled;
    data['username'] = this.username;
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    data['password'] = this.password;
    data['authorities'] = this.authorities;
    return data;
  }
}

class EmployeId {
  String? id;
  dynamic? createDate;
  dynamic? createBy;
  dynamic? lastUpdateDate;
  dynamic? updateBy;
  String? firstName;
  dynamic? middleName;
  String? lastName;
  dynamic? nickName;
  dynamic? phoneticName;
  String? jobTitle;
  dynamic? pronoun;
  dynamic? phone;
  String? email;
  dynamic? birthdate;
  String? gender;
  dynamic? startDate;
  dynamic? endDate;
  bool? indigenousFlag;
  EmployeType? employeType;
  String? departmentIdx;
  dynamic? profileImage;

  EmployeId(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.firstName,
        this.middleName,
        this.lastName,
        this.nickName,
        this.phoneticName,
        this.jobTitle,
        this.pronoun,
        this.phone,
        this.email,
        this.birthdate,
        this.gender,
        this.startDate,
        this.endDate,
        this.indigenousFlag,
        this.employeType,
        this.departmentIdx,
        this.profileImage});

  EmployeId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    nickName = json['nickName'];
    phoneticName = json['phoneticName'];
    jobTitle = json['jobTitle'];
    pronoun = json['pronoun'];
    phone = json['phone'];
    email = json['email'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    indigenousFlag = json['indigenousFlag'];
    employeType = json['employeType'] != null
        ? new EmployeType.fromJson(json['employeType'])
        : null;
    departmentIdx = json['departmentIdx'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['updateBy'] = this.updateBy;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['nickName'] = this.nickName;
    data['phoneticName'] = this.phoneticName;
    data['jobTitle'] = this.jobTitle;
    data['pronoun'] = this.pronoun;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['indigenousFlag'] = this.indigenousFlag;
    if (this.employeType != null) {
      data['employeType'] = this.employeType!.toJson();
    }
    data['departmentIdx'] = this.departmentIdx;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class EmployeType {
  String? id;
  String? createDate;
  dynamic? createBy;
  dynamic? lastUpdateDate;
  dynamic? updateBy;
  String? name;

  EmployeType(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.name});

  EmployeType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'];
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    data['createBy'] = this.createBy;
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['updateBy'] = this.updateBy;
    data['name'] = this.name;
    return data;
  }
}

class EmployeId1 {
  String? id;
  String? createDate;
  CreateBy? createBy;
  dynamic? lastUpdateDate;
  dynamic? updateBy;
  String? firstName;
  String? middleName;
  String? lastName;
  dynamic? nickName;
  dynamic? phoneticName;
  String? jobTitle;
  dynamic? pronoun;
  String? phone;
  String? email;
  String? birthdate;
  String? gender;
  String? startDate;
  dynamic? endDate;
  bool? indigenousFlag;
  EmployeType? employeType;
  String? departmentIdx;
  dynamic? profileImage;

  EmployeId1(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.firstName,
        this.middleName,
        this.lastName,
        this.nickName,
        this.phoneticName,
        this.jobTitle,
        this.pronoun,
        this.phone,
        this.email,
        this.birthdate,
        this.gender,
        this.startDate,
        this.endDate,
        this.indigenousFlag,
        this.employeType,
        this.departmentIdx,
        this.profileImage});

  EmployeId1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createDate = json['createDate'];
    createBy = json['createBy'] != null
        ? new CreateBy.fromJson(json['createBy'])
        : null;
    lastUpdateDate = json['lastUpdateDate'];
    updateBy = json['updateBy'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    nickName = json['nickName'];
    phoneticName = json['phoneticName'];
    jobTitle = json['jobTitle'];
    pronoun = json['pronoun'];
    phone = json['phone'];
    email = json['email'];
    birthdate = json['birthdate'];
    gender = json['gender'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    indigenousFlag = json['indigenousFlag'];
    employeType = json['employeType'] != null
        ? new EmployeType.fromJson(json['employeType'])
        : null;
    departmentIdx = json['departmentIdx'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createDate'] = this.createDate;
    if (this.createBy != null) {
      data['createBy'] = this.createBy!.toJson();
    }
    data['lastUpdateDate'] = this.lastUpdateDate;
    data['updateBy'] = this.updateBy;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['nickName'] = this.nickName;
    data['phoneticName'] = this.phoneticName;
    data['jobTitle'] = this.jobTitle;
    data['pronoun'] = this.pronoun;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['birthdate'] = this.birthdate;
    data['gender'] = this.gender;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['indigenousFlag'] = this.indigenousFlag;
    if (this.employeType != null) {
      data['employeType'] = this.employeType!.toJson();
    }
    data['departmentIdx'] = this.departmentIdx;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class LeaveType {
  String? id;
  String? createDate;
  dynamic? createBy;
  dynamic? lastUpdateDate;
  dynamic? updateBy;
  String? name;
  String? leaveDescription;
  int? numberDaysAllowed;

  LeaveType(
      {this.id,
        this.createDate,
        this.createBy,
        this.lastUpdateDate,
        this.updateBy,
        this.name,
        this.leaveDescription,
        this.numberDaysAllowed});

  LeaveType.fromJson(Map<String, dynamic> json) {
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

