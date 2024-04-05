import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  const AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: const Color(0xFF8C3488),
      ),
      backgroundColor: const Color(0xFF8C3488),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/yo.jpg'),
            ),
            SizedBox(height: 16),
            Text(
              'Nombre: Yohary Nuñez',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              'Matrícula: 2021-2335',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Frase relacionada:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              '"La democracia es el gobierno del pueblo, por el pueblo y para el pueblo."',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}