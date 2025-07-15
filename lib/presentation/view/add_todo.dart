import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoAdd extends StatelessWidget {
  final TextEditingController _todoController;
  final VoidCallback onAddPressed; // Callback para quando clicar no botão

  TodoAdd({
    Key? key,
    required TextEditingController todoController,
    required this.onAddPressed,
  })  : _todoController = todoController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 250,
          child: TextField(
            controller: _todoController,

            decoration: InputDecoration(

              labelText: 'Digite algo',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 12,
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10), // espaço entre os dois
        ElevatedButton(
          onPressed: onAddPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(60, 60), // largura: 60, altura: 60
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4), // menor arredondamento
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
