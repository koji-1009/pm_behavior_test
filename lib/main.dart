import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Test app', home: const AutofillPage());
  }
}

class AutofillPage extends StatefulWidget {
  const AutofillPage({super.key});

  @override
  State<AutofillPage> createState() => _AutofillPageState();
}

class _AutofillPageState extends State<AutofillPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void moveNext() {
      TextInput.finishAutofillContext();
      Navigator.push<void>(
        context,
        MaterialPageRoute(builder: (context) => const CheckPage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Save PW iOS'),
        actions: [
          IconButton(
            onPressed: () {
              email.clear();
              password.clear();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AutofillGroup(
            onDisposeAction: AutofillContextAction.cancel,
            child: Column(
              children: [
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Username"),
                  autofillHints: const [AutofillHints.email],
                  textInputAction: TextInputAction.next,
                ),
                TextField(
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(labelText: "Password"),
                  autofillHints: const [AutofillHints.password],
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) => moveNext(),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          FilledButton(
            onPressed: () => moveNext(),
            child: const Text('Push SimplePage'),
          ),
        ],
      ),
    );
  }
}

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check Page')),
      body: Center(
        child: SizedBox.square(
          dimension: 100,
          child: ColoredBox(color: Colors.blue),
        ),
      ),
    );
  }
}
