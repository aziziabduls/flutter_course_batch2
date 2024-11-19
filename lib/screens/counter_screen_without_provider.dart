import 'package:flutter/material.dart';

class CounterScreenWithoutProvider extends StatefulWidget {
  const CounterScreenWithoutProvider({super.key});

  @override
  State<CounterScreenWithoutProvider> createState() => _CounterScreenWithoutProviderState();
}

class _CounterScreenWithoutProviderState extends State<CounterScreenWithoutProvider> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('>> build without provider');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App Without Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              counter.toString(),
              style: TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                increment();
              },
              child: Text(
                'Increment',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
