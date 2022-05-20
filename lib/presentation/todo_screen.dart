import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_flutter/model/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int? id;
  bool isComplete = false;
  var todoController = TextEditingController();

  final List<Todo> _todos = [Todo(id: 1, todo: 'Makan', isComplete: false)];

  void clearForm() {
    id = null;
    isComplete = false;
    todoController.clear();
  }

  void onSubmit() {
    setState(() {
      if (todoController.text.isNotEmpty && id == null) {
        _todos.add(Todo(
            id: _todos.length < 1 ? 1 : _todos[_todos.length - 1].id! + 1,
            todo: todoController.text,
            isComplete: isComplete));
        clearForm();
      } else if (todoController.text.isNotEmpty && id != null) {
        var todoIdx =
        _todos.indexWhere((element) => element.id == id);
        _todos[todoIdx] = Todo(
            id: id,
            isComplete: isComplete,
            todo: todoController.text);
        clearForm();
      } else {
        showSnackBar(message: 'Todo cannot be empty!', actionLabel:  'Close');
      }
    });
  }

  void showSnackBar({required String message, required String actionLabel, Function? callback}) {
    var snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
            label: actionLabel, onPressed: () => callback));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24, left: 16, right: 16),
              child: TextField(
                decoration: const InputDecoration(
                  label: Text('Todo'),
                ),
                controller: todoController,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: CheckboxListTile(
                title: const Text('Completed'),
                contentPadding: EdgeInsets.zero,
                value: isComplete,
                controlAffinity: ListTileControlAffinity.leading,
                onChanged: (value) {
                  setState(() {
                    isComplete = value!;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () => onSubmit(),
                    child: const Text('Save'),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    onPressed: () {
                      setState(() {
                        todoController.clear();
                        isComplete = false;
                      });
                    },
                    child: const Text('Clear'),
                  )
                ],
              ),
            ),
            const Divider(height: 24),
            Container(
              margin: const EdgeInsets.only(top: 8, bottom: 16),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'List Todo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      id = _todos[index].id;
                      todoController.text = _todos[index].todo!;
                      isComplete = _todos[index].isComplete;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              '${_todos[index].todo}',
                              style: TextStyle(
                                  decoration: _todos[index].isComplete
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => setState(() {
                          _todos.removeAt(index);
                        }),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
