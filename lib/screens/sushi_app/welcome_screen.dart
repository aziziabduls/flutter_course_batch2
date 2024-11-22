import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_course_batch_2/screens/sushi_app/dashboard.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Suhiman',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sushi_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Japanese taste of Japanese Food',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
              Text(
                'Feel the tase of the most popular Japanese food from around the world.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: CupertinoButton(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(CupertinoIcons.arrow_right),
                      ],
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Dashboard()),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
