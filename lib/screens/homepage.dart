import 'package:flutter/material.dart';
import 'package:helloworld/widgets/profile_dropdown.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartJewelry'),
        backgroundColor: Colors.black,
        actions: const [
          ProfileDropdown(),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to your Jewelry Design Hub!',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}
