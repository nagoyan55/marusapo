import 'package:flutter/material.dart';
import 'package:myapp/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  MealDetailScreen({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('材料', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...meal.ingredients.map((ingredient) => Text('${ingredient.name}: ${ingredient.quantity} ${ingredient.unit}')).toList(),
            SizedBox(height: 20),
            Text('レシピ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(meal.recipe.description),
          ],
        ),
      ),
    );
  }
}
