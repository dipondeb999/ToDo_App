import 'package:flutter/material.dart';
import 'package:todo_app/presentation/screens/home_screen.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: HomeScreen(),
    );
  }
}
