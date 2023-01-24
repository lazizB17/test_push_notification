import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const id = "/home_page";
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
    );
  }
}

