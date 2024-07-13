import 'package:financial/pages/leave_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Remove const from here

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/leave': (context) => const LeavePage(),
      },
      home: const LeavePage(),
    );
  }
}
