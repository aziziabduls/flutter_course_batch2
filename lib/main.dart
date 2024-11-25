import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/provider/cart_provider.dart';
import 'package:flutter_course_batch_2/provider/counter_provider.dart';
import 'package:flutter_course_batch_2/screens/about_screen.dart';
import 'package:flutter_course_batch_2/screens/emoji_generator.dart';
import 'package:flutter_course_batch_2/screens/splash_screen.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/welcome_screen.dart';
import 'package:flutter_course_batch_2/service_provider/dio_client.dart';
import 'package:flutter_course_batch_2/service_provider/error_notifier.dart';
import 'package:flutter_course_batch_2/service_provider/service_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  final dio = Dio();
  final dioClient = DioClient(dio);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider(dioClient)),
        ChangeNotifierProvider(create: (_) => ErrorNotifier()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Urbanist',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/about': (context) => const AboutScreen(title: 'About'),
        '/emojiGenerator': (context) => const EmojiGenerator(),
        '/sushi': (context) => const WelcomeScreen(),
      },
    );
  }
}
