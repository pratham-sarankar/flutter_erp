import 'package:flutter/cupertino.dart';

class Cell {
  final String? data;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isAction;
  final List<Cell> children;

  Cell({
    this.data,
    this.icon,
    this.onPressed,
    this.isAction = false,
    this.children = const [],
  });
}
