import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/todo_app.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const ToDoApp());
}
