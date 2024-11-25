// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/module/secure_storage_module.dart';
import 'package:flutter_course_batch_2/screens/about_screen.dart';
import 'package:flutter_course_batch_2/screens/counter_screen.dart';
import 'package:flutter_course_batch_2/screens/counter_screen_without_provider.dart';
import 'package:flutter_course_batch_2/screens/fetch_api_example/fetch_api_screen.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/welcome_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Course Batch 2',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Urbanist',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellowAccent,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        children: [
          //Anonymous Route
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Anonymous Route'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutScreen(title: 'About Screen'),
                  ),
                );
              },
            ),
          ),

          // Named Route
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Named Route'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ),

          // Emoji Generator
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Emoji Generator'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/emojiGenerator',
                  arguments: {
                    'length': 3,
                  },
                );
              },
            ),
          ),

          // Counter App with Provider
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Counter App with Provider'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterScreen()),
                );
              },
            ),
          ),

          // Counter App not using Provider
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Counter App without Provider'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CounterScreenWithoutProvider()),
                );
              },
            ),
          ),

          // Sushi App
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Sushi App'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () async {
                await SecureStorageModule().write(key: 'isSushiApp', value: 'true');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false,
                );
              },
            ),
          ),

          // Fetch API
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(
                  color: Colors.grey,
                ),
              ),
              title: Text('Fetch API'),
              trailing: Icon(CupertinoIcons.arrow_right),
              onTap: () async {
                await SecureStorageModule().write(key: 'isSushiApp', value: 'true');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FetchAPIScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          children: const [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Build With Flutter',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 6),
                  FlutterLogo(
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
