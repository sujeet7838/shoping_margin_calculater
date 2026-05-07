import 'package:calculater/screens/dashboard.dart';
import 'package:calculater/screens/dashboard_b2b.dart';
import 'package:calculater/utils/custom_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80,
              left: 20,
              right: 20,
              bottom: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        colors: [
                          Color(0xFF153855),
                          Color.fromARGB(255, 238, 7, 180),
                        ],
                      ).createShader(bounds),
                  child: Text(
                    'NoteBook Calculator',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Spacer(),

                CardButton(
                  title: "B2B",
                  imagePath: "assets/images/b2b.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DeshboardB2BPage()),
                    );
                  },
                ),

                SizedBox(height: 10),

                CardButton(
                  title: "B2C",
                  imagePath: "assets/images/b2c.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DeshboardPage()),
                    );
                  },
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
