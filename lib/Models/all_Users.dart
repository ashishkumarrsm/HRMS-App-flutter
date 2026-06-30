import 'dart:convert';

AllUser allUserFromJson(String str) => AllUser.fromJson(json.decode(str));
String allUserToJson(AllUser data) => json.encode(data.toJson());

class AllUser {
  int? statusCodes;
  String? message;
  Pagination? pagination;
  List<UserData>? data;

  AllUser({this.statusCodes, this.message, this.pagination, this.data});

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        statusCodes: json["statusCodes"],
        message: json["message"],
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
        data: json["data"] == null
            ? []
            : List<UserData>.from(
                json["data"].map((x) => UserData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCodes": statusCodes,
        "message": message,
        "pagination": pagination?.toJson(),
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

class Pagination {
  int? total;
  int? page;
  int? limit;
  int? totalPages;

  Pagination({this.total, this.page, this.limit, this.totalPages});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
      };
}

class UserData {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  dynamic assignedDepartment;
  dynamic assignedDepartmentId;
  String? role;
  String? category;
  String? roleName;
  String? status;
  String? lastLogin;
  String? createdAt;
  List<dynamic>? hospitalDepartments;
  List<dynamic>? hospitalCategory;

  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.assignedDepartment,
    this.assignedDepartmentId,
    this.role,
    this.category,
    this.roleName,
    this.status,
    this.lastLogin,
    this.createdAt,
    this.hospitalDepartments,
    this.hospitalCategory,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        assignedDepartment: json["assignedDepartment"],
        assignedDepartmentId: json["assignedDepartmentId"],
        role: json["role"],
        category: json["category"],
        roleName: json["roleName"],
        status: json["status"],
        lastLogin: json["lastLogin"],
        createdAt: json["createdAt"],
        hospitalDepartments: json["hospitalDepartments"] == null
            ? []
            : List<dynamic>.from(json["hospitalDepartments"]),
        hospitalCategory: json["hospitalcategory"] == null
            ? []
            : List<dynamic>.from(json["hospitalcategory"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "assignedDepartment": assignedDepartment,
        "assignedDepartmentId": assignedDepartmentId,
        "role": role,
        "category": category,
        "roleName": roleName,
        "status": status,
        "lastLogin": lastLogin,
        "createdAt": createdAt,
        "hospitalDepartments": hospitalDepartments,
        "hospitalcategory": hospitalCategory,
      };
}