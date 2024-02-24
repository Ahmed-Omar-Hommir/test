import 'package:flutter/material.dart';

class GuestScreen extends StatelessWidget {
  const GuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onPressed: () {},
        child: const Text('Sign In'),
      ),
    ));
  }
}
