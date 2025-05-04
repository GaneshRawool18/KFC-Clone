import 'package:flutter/material.dart';

class NutritionAllergenPage extends StatelessWidget {
  const NutritionAllergenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nutrition & Allergen Info"),
        backgroundColor: Colors.redAccent,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Nutrition & Allergen content goes here...',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
