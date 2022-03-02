// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/controller/todo_controller.dart';
import 'package:lista_de_tarefas/widgets/item_todo_list.dart';

import '../models/todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? error;
  List<Todo> todoList = [];
  final tarefasTextController = TextEditingController();
  final TodoController todoController = TodoController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoController.getTodoList().then((value) {
      setState(() {
        todoList = value;
      });
    });
  }

  void addTarefa() {
    String txt = tarefasTextController.text;
    if (txt.isEmpty) {
      setState(() {
        error = "Informe uma tarefa para adicionar";
      });
    } else {
      setState(() {
        error = null;
        Todo todo = Todo(
          title: txt,
          dateTime: DateTime.now(),
        );
        todoList.add(todo);
      });
      todoController.saveTodoList(todoList);
    }
    tarefasTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Adicione uma tarefa",
                      errorText: error,
                    ),
                    controller: tarefasTextController,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  //Botão para inserir uma nova tarefa
                  onPressed: addTarefa,
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18)),
                )
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemTodoList(
                    todo: todoList[index],
                    onDelete: todoDelete,
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child:
                      Text("Você possui ${todoList.length} tarefas pendentes."),
                ),
                ElevatedButton(
                    onPressed: showMsgConfirmDeleteAllTodos,
                    child: const Text("Limpar tudo"))
              ],
            )
          ],
        ),
      ),
    );
  }

  void todoDelete(Todo todo) {
    int idxOf = todoList.indexOf(todo);
    setState(() {
      todoList.remove(todo);
      todoController.saveTodoList(todoList);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 134, 134, 134),
        content: Text("Tarefa \"${todo.title}\" delatada com sucesso."),
        action: SnackBarAction(
          label: "Desfazer",
          onPressed: () {
            setState(() {
              todoList.insert(idxOf, todo);
              todoController.saveTodoList(todoList);
            });
          },
        ),
      ),
    );
  }

  void showMsgConfirmDeleteAllTodos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(
              Icons.dangerous,
              color: Colors.orange,
            ),
            Text("Deseja Deletar?"),
            Icon(
              Icons.dangerous,
              color: Colors.orange,
            ),
          ],
        ),
        content: const Text(
            "Tem certeza que deseja deletar todas as tarefas?\nEssa ação não poderá ser desfeita."),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                todoList.clear();
                todoController.saveTodoList(todoList);
              });
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(primary: Colors.red),
            child: Text(
              "Deletar Tudo",
            ),
          ),
        ],
      ),
    );
  }
}
