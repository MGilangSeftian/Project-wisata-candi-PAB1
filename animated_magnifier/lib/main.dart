import 'package:animated_magnifier/%20animated_magnifier.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
        title: Text('Animated controller'),
        backgroundColor: Colors.blue[100],
      ),
      body: const Center(
        child: AnimatedMagnifier(),
      ),
      ),
    );
  }
}
