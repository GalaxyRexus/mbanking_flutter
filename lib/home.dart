import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      fallbackHeight: 200,
      fallbackWidth: 200,
      color: Colors.blue,
      strokeWidth: 2.0,
    );
  }
}