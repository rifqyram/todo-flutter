import 'package:flutter/material.dart';
import 'package:todo_flutter/presentation/todo_screen.dart';

import '../widget/custom_button.dart';

class MainForm extends StatefulWidget {
  const MainForm({Key? key}) : super(key: key);

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Input Your Name',
                style: TextStyle(color: Colors.amber, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: TextFormField(
                  style: const TextStyle(color: Colors.amber),
                  controller: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name can't be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber)),
                      label: Text('Full Name')),
                ),
              ),
              CustomButton(
                height: 40,
                width: 100,
                label: 'Mulai',
                onTap: () {
                  if (!_formKey.currentState!.validate()) return;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => TodoScreen(
                                name: nameController.text,
                              ))));
                },
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(16)),
                splashColor: Colors.amber.shade400,
                borderRadius: BorderRadius.circular(16),
                textStyle: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
