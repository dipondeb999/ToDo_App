import 'package:flutter/material.dart';
import 'package:todo_app/presentation/constants/color.dart';
import 'package:todo_app/presentation/models/todo.dart';
import 'package:todo_app/presentation/widgets/todo_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ToDo> toDoList = ToDo.todoList();
  final TextEditingController _toDoTEController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    _foundToDo = toDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                _buildSearchBox(),
                _buildShowAllToDos(),
              ],
            ),
          ),
          _buildInputToDoItem(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/avatar.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGrey,
          ),
        ),
      ),
    );
  }

  Widget _buildShowAllToDos() {
    return Expanded(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50, bottom: 20),
            child: const Text(
              'All ToDos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (ToDo todo in _foundToDo.reversed)
            ToDoItem(
              todo: todo,
              onToDoChanged: _handleToDoChange,
              onDeleteItem: _deleteToDoItem,
            ),
        ],
      ),
    );
  }

  Widget _buildInputToDoItem() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: TextField(
                controller: _toDoTEController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a new todo item',
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20, bottom: 20),
            child: ElevatedButton(
              onPressed: () {
                _addToDoItem(_toDoTEController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                minimumSize: const Size(60, 60),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    todo.isDone =! todo.isDone;
    setState(() {});
  }

  void _deleteToDoItem(ToDo todo) {
    toDoList.removeWhere((item) => item.id == todo.id);
    _foundToDo.removeWhere((item) => item.id == todo.id);
    setState(() {});
  }

  void _addToDoItem(String toDo) {
    toDoList.add(ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      todoText: toDo,
    ));
    _toDoTEController.clear();
    _foundToDo = toDoList;
    setState(() {});
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = toDoList;
    } else {
      results = toDoList
          .where((item) =>
          item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    _foundToDo = results;
    setState(() {});
  }
}
