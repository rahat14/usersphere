// To parse this JSON data, do
//
//     final userListResp = userListRespFromJson(jsonString);

import 'dart:convert';

UserListResp userListRespFromJson(String str) => UserListResp.fromJson(json.decode(str));

String userListRespToJson(UserListResp data) => json.encode(data.toJson());

class UserListResp {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User>? data;
  Support? support;

  UserListResp({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  UserListResp copyWith({
    int? page,
    int? perPage,
    int? total,
    int? totalPages,
    List<User>? data,
    Support? support,
  }) =>
      UserListResp(
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
        totalPages: totalPages ?? this.totalPages,
        data: data ?? this.data,
        support: support ?? this.support,
      );

  factory UserListResp.fromJson(Map<String, dynamic> json) => UserListResp(
    page: json["page"],
    perPage: json["per_page"],
    total: json["total"],
    totalPages: json["total_pages"],
    data: json["data"] == null ? [] : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
    support: json["support"] == null ? null : Support.fromJson(json["support"]),
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "per_page": perPage,
    "total": total,
    "total_pages": totalPages,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "support": support?.toJson(),
  };
}

class User {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  User copyWith({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) =>
      User(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatar: avatar ?? this.avatar,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "avatar": avatar,
  };

  String get userFullName {
    return '$firstName $lastName';
  }



}

class Support {
  String? url;
  String? text;

  Support({
    this.url,
    this.text,
  });

  Support copyWith({
    String? url,
    String? text,
  }) =>
      Support(
        url: url ?? this.url,
        text: text ?? this.text,
      );

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    url: json["url"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "text": text,
  };
}
