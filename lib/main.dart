import 'package:flutter/material.dart';
import 'package:eleccione_20212335/Screens/home.dart';

void main() => runApp(const Myapp());

class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomeScreen()
      ),
    );
  }
}

