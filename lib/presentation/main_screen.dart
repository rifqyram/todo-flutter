import 'package:flutter/material.dart';
import 'package:todo_flutter/presentation/main_form.dart';
import 'package:todo_flutter/widget/custom_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Selamat Datang',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Image(
                width: 250,
                image: AssetImage('assets/images/task.png'),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 24, top: 16),
              child: const Text(
                'Mulailah dengan semangat dan senyuman',
                style: TextStyle(color: Colors.amber, fontSize: 14),
              ),
            ),
            CustomButton(
              height: 40,
              width: 100,
              label: 'Mulai',
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => const MainForm()))),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(16)),
              splashColor: Colors.amber.shade400,
              borderRadius: BorderRadius.circular(16),
              textStyle: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
