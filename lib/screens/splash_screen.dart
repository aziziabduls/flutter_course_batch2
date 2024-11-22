// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/module/secure_storage_module.dart';
import 'package:flutter_course_batch_2/screens/home_screen.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> getData() async {
    String isSushiApp = await SecureStorageModule().read(key: 'isSushiApp') ?? '';
    debugPrint('>>> hasil : $isSushiApp');
    if (isSushiApp == 'true') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  Future<void> _getDataStorage() async {
    try {
      getData();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3), () {
        _getDataStorage();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
