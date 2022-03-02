import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class ItemTodoList extends StatelessWidget {
  const ItemTodoList({
    Key? key,
    required this.todo,
    required this.onDelete,
  }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Slidable(
        child: ListTile(
          dense: true,
          style: ListTileStyle.drawer,
          title: Text(todo.title),
          subtitle:
              Text(DateFormat('dd/MM/yyyy HH:mm:ss').format(todo.dateTime)),
          onTap: () {
            print(todo.title);
          },
        ),
        endActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                onDelete(todo);
              },
              backgroundColor: Colors.red,
              label: "Deletar",
              icon: Icons.delete,
            ),
          ],
        ),
      ),
    );
  }
}
