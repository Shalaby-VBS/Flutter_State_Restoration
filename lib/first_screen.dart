import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_restoration/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

// MARK: - Adding RestorationMixin To Screen State.
class _FirstScreenState extends State<FirstScreen> with RestorationMixin {
  final RestorableTextEditingController _controller = RestorableTextEditingController();
  RestorableBool isChecked = RestorableBool(false);

  @override
  void initState() {
    super.initState();
  }

  // MARK: - Adding Navigation Function.
  static Route<void> _secondScreenNavigation(BuildContext context, Object? arguments) {
    return MaterialPageRoute(
      builder: (context) => const SecondScreen()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'First Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller.value,
              decoration: const InputDecoration(
                labelText: 'Enter Your Name',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
              width: 174,
              child: CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: isChecked.value,
                onChanged: (value) {
                  setState(() {
                    isChecked.value = value!;
                  });
                },
                title: const Text('🟣Is Developer'),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton.filled(
                onPressed: () {
                  // MARK: - Change push To restorablePush.
                  Navigator.restorablePush(
                    context,
                    _secondScreenNavigation,
                  );
                },
                child: const Text('Go to Second Screen'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // MARK: - Adding Required Restoration Properties To Screen State.
  @override
  String? get restorationId => "firstScreen";

  // MARK: - Adding The Data You Need To Store.
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_controller, 'text_field');
    registerForRestoration(isChecked, 'is_checked');
  }
}
