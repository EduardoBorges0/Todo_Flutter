import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todo;
  final bool isEditing;
  final Function()? onTap;
  final Function()? onDelete;
  final bool isDone;
  final Function(bool? isDone)? onIsDone;
  final Function(String)? onChanged;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.isEditing,
    required this.isDone,
    this.onIsDone,
    this.onDelete,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  width: isEditing ? 300 : 370,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.deepPurple.shade200),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          todo,
                          style: TextStyle(
                            fontSize: 16,
                            decoration:
                                isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Checkbox(
                        value: isDone,
                        onChanged: (bool? value) {
                          onIsDone?.call(value);
                        },
                        activeColor: Colors.deepPurple,
                      ),
                    ],
                  ),
                ),

                if (isEditing)
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {
                      onDelete?.call();
                    },
                  ),
              ],
            ),
            if (isEditing)
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      style: TextStyle(
                        height: 2
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Editar tarefa...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            SizedBox(height: isEditing ? 25 : 0),
          ],
        ),
      ),
    );
  }
}
