import 'package:flutter/material.dart';

void newPageDestroyPrevious(BuildContext context, String routeName) {
  Navigator.pushReplacementNamed(context, routeName);
}