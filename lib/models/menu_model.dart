import 'package:flutter/material.dart';

class MenuElement {
  final String text;

  MenuElement({required this.text});
}

class Menuitems {
  static List<MenuElement> items = [deleteItem, editItem];
  static final deleteItem = MenuElement(text: "Delete");
  static final editItem = MenuElement(text: "Edit");
}
