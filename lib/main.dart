import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/provider/counter_provider.dart';
import 'package:flutter_course_batch_2/screens/about_screen.dart';
import 'package:flutter_course_batch_2/screens/emoji_generator.dart';
import 'package:flutter_course_batch_2/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CounterProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutScreen(title: 'About'),
        '/emojiGenerator': (context) => const EmojiGenerator(),
      },
    );
  }
}
