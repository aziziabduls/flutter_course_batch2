import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/module/secure_storage_module.dart';
import 'package:flutter_course_batch_2/screens/home_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Center(
              child: CircleAvatar(
                radius: 80,
                child: Icon(
                  Icons.person,
                  size: 120,
                ),
              ),
            ),
          ),
          Spacer(),
          CupertinoButton(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(30),
            child: Text('Logout'),
            onPressed: () async {
              await SecureStorageModule().write(key: 'isSushiApp', value: 'false').then((value) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false,
                );
              });
              String isSushiApp = await SecureStorageModule().read(key: 'isSushiApp') ?? 'false';
              debugPrint('>>> hasil : $isSushiApp');
            },
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
