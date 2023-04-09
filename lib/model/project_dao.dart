import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class ProjectDao {
  final String _id;
  final String _code;
  final String _description;
  final bool _special;
  final Color? _color;

  ProjectDao(
      {String? id, required code, required description, special = false, color})
      : _id = id ?? const Uuid().toString(),
        _code = code,
        _description = description,
        _special = special,
        _color = color;

  factory ProjectDao.fromMap(Map<String, dynamic> map) {
    Color c = Colors.black;
    switch (map["color"]) {
      case 1:
        c = Colors.red;
        break;
      default:
        c = Colors.black;
    }

    return ProjectDao(
        id: map["id"],
        code: map["code"],
        description: map["description"],
        special: map["special"] as int == 1,
        color: c);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> res = {
      "id": _id,
      "code": _code,
      "description": _description,
    };

    res["special"] = _special ? 1 : 0;
    res["color"] = _color == Colors.red ? 1 : 0;

    return res;
  }

  @override
  String toString() {
    return 'ProjectDao{_id: $_id, _code: $_code, _description: $_description, _special: $_special, _color: $_color}';
  }

  Color? get color => _color;

  bool get special => _special;

  String get description => _description;

  String get code => _code;

  String get id => _id;
}
