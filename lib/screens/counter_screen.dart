import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/provider/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter App With Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<CounterProvider>(
              builder: (context, value, child) {
                return Text(
                  value.counter.toString(),
                  style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterProvider>().increment();
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
