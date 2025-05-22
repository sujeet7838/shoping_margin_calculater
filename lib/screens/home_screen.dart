import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Calculator'),
      //   centerTitle: true,
      //   backgroundColor: Colors.pinkAccent,
      // ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 25),
                Text(
                  "Calculator App",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 92, 91, 91),
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(166, 255, 255, 255),
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color.fromARGB(255, 37, 37, 37),
                    ),
                  ),
                  style: TextStyle(color: Colors.black),
                ),

                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    // Handle button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
