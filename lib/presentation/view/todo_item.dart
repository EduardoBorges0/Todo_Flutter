import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        width: 350, // fixa a largura
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.deepPurple.shade200),
        ),
        child: Text(
          todo,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.deepPurple,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

}
