import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_flutter/model/todo.dart';
import 'package:todo_flutter/presentation/todo_form.dart';

class TodoScreen extends StatefulWidget {

  String? name = "There";

  TodoScreen({Key? key, this.name}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [
    Todo(
      id: 1,
      todo: 'Makan',
      description: 'Makan Nasi',
      isComplete: false,
    )
  ];

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () async {
        var result = await Navigator.push(context,
            MaterialPageRoute(builder: ((context) => TodoForm())));
        var todo = result as Todo;
        onSaveTodo(todo);
      },
      backgroundColor: Colors.white,
      child: const Icon(
        Icons.add,
      ),
    );
  }

  void onSaveTodo(Todo? todo) {
    if (todo != null && todo.id == null) {
      todo.id = todos.length < 1 ? 1 : todos[todos.length - 1].id! + 1;
      setState(() {
        todos.add(todo);
      });
    } else {
      var idxTodo = todos.indexWhere((element) => element.id == todo?.id);
      setState(() {
        todos[idxTodo] = todo!;
      });
    }
  }

  Widget bottomNavBarGenerate() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        children: [
          Container(
            height: 50,
          )
        ],
      ),
    );
  }

  Widget buildDateSection() {
    List<String> dates = DateFormat('y-MMMM-EEEE-d').format(DateTime.now()).split('-');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        children: [
          Text(dates[3],
            style: const TextStyle(
                fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dates[2],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  '${dates[1]} ${dates[0]}',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildIdentitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 60,
              width: 60,
            ),
          ),
          Text(
            'Hi, ${widget.name}',
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildTodoSection() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, top: 16),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16, left: 24, bottom: 8),
            child: Text(
              'Today',
              style: TextStyle(
                  color: Color(0xFF8987AB),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: ((context, index) => Slidable(
                      endActionPane: ActionPane(
                        motion: const BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              setState(() {
                                todos.removeAt(index);
                              });
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                          )
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TodoForm(
                                  id: todos[index].id,
                                  todo: todos[index].todo,
                                  content: todos[index].description,
                                ),
                              ));
                          var todo = result as Todo;
                          onSaveTodo(todo);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: todos[index].isComplete,
                                  onChanged: (val) {
                                    setState(() {
                                      todos[index].isComplete = val!;
                                    });
                                  }),
                              Text(
                                '${todos[index].todo}',
                                style: TextStyle(
                                    color: todos[index].isComplete
                                        ? const Color(0xFFD7D7E0)
                                        : const Color(0xFF8987AB),
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(),
      bottomNavigationBar: bottomNavBarGenerate(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.amber.shade600,
      body: SafeArea(
        bottom: true,
        child: ListView(
          children: [
            buildIdentitySection(),
            buildDateSection(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'While there is life there is hope',
                style: TextStyle(color: Colors.white),
              ),
            ),
            buildTodoSection()
          ],
        ),
      ),
    );
  }
}
