import 'package:flutter/material.dart';
import '../theme.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sentiment_satisfied, color: AppColors.primary, size: 100),
            const SizedBox(height: 20),
            Text(
              "¡Bienvenido!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text("Nos alegra verte de nuevo 😊"),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/diary');
              },
              child: const Text("Ir a mi diario"),
            ),
          ],
        ),
      ),
    );
  }
}
