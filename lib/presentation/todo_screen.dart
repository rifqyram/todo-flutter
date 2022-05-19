import 'package:flutter/material.dart';
import 'package:todo_flutter/model/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  bool isComplete = false;
  var todoController = TextEditingController();

  final List<Todo> _todos = [Todo(todo: 'Makan', isComplete: false)];

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
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (todoController.text.isNotEmpty) {
                      _todos.add(Todo(
                          todo: todoController.text, isComplete: isComplete));
                    } else {
                      var snackBar = SnackBar(
                        content: const Text('Todo cannot be empty!'),
                        action: SnackBarAction(label: 'Close', onPressed: () {})
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
                child: const Text('Save'),
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
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Text(_todos[index].todo!)
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
          ],
        ),
      ),
    );
  }
}
