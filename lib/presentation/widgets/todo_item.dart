import 'package:flutter/material.dart';
import 'package:todo_app/presentation/constants/color.dart';
import 'package:todo_app/presentation/models/todo.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {super.key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          widget.onToDoChanged(widget.todo);
        },
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        leading: Icon(
          widget.todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Text(
          widget.todo.todoText!,
          style: TextStyle(
            color: tdBlack,
            fontSize: 16,
            decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: () {
              widget.onDeleteItem(widget.todo);
            },
            color: Colors.white,
            iconSize: 18,
            icon: const Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
