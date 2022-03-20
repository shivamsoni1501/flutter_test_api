import 'package:flutter/material.dart';
import 'dart:convert';

class APIModel {
  static const String ID = 'id';
  static const String FULLNAME = 'full_name';
  static const String PRIVATE = 'private';
  static const String OWNER = 'owner';
  static const String AVATAR = 'avatar_url';
  static const String DESCRIPTION = 'description';
  static const String HASPAGES = 'has_pages';
  static const String FORKS = 'forks';

  static Map<int, APIModel> repos = {};

  int id;
  String fullname;
  bool private;
  String avatar;
  String description;
  bool haspages;
  int forks;

  APIModel(
      {required this.id,
      required this.fullname,
      required this.private,
      required this.avatar,
      required this.description,
      required this.haspages,
      required this.forks});

  factory APIModel.fromMap(Map<String, dynamic> json) {
    return APIModel(
      id: json[APIModel.ID] as int,
      fullname: json[APIModel.FULLNAME] as String,
      private: json[APIModel.PRIVATE] as bool,
      avatar: json[APIModel.OWNER][APIModel.AVATAR] as String,
      description: json[APIModel.DESCRIPTION] as String,
      haspages: json[APIModel.HASPAGES] as bool,
      forks: json[APIModel.FORKS] as int,
    );
  }

  APIModel copy() {
    return APIModel(
        id: id,
        fullname: fullname,
        private: private,
        avatar: avatar,
        description: description,
        haspages: haspages,
        forks: forks);
  }

  String toJson() {
    return jsonEncode({
      APIModel.ID: id,
      APIModel.FULLNAME: fullname,
      APIModel.PRIVATE: private,
      APIModel.OWNER: {
        APIModel.AVATAR: avatar,
      },
      APIModel.DESCRIPTION: description,
      APIModel.HASPAGES: haspages,
      APIModel.FORKS: forks
    });
  }
}
