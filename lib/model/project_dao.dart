import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class ProjectDao {
  final Uuid _id;
  final String _code;
  final String _description;
  final bool _special;
  final Color? _color;

  const ProjectDao(
      {id = const Uuid(),
      required code,
      required description,
      special = false,
      color})
      : _id = id,
        _code = code,
        _description = description,
        _special = special,
        _color = color;

  Color? get color => _color;

  bool get special => _special;

  String get description => _description;

  String get code => _code;

  Uuid get id => _id;
}
