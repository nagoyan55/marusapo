import 'package:flutter/material.dart';
import 'package:myapp/logics/ingredient.dart';
import '../models/week_plan.dart';
import '../util/checked_ingredients_manager.dart';
import '../models/checked_ingredient.dart';

class ShoppingListScreen extends StatefulWidget {
  final WeekPlan weekPlan;

  ShoppingListScreen({required this.weekPlan});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  Map<String, bool> _checkedIngredients = {};

  @override
  void initState() {
    super.initState();
    _loadCheckedIngredients();
  }

  Future<void> _loadCheckedIngredients() async {
    List<CheckedIngredient> checkedIngredients = await CheckedIngredientsManager.loadCheckedIngredients();
    setState(() {
      _checkedIngredients = {
        for (var ingredient in checkedIngredients) ingredient.name: ingredient.isChecked
      };
    });
  }

  Future<void> _toggleIngredient(String name, bool isChecked) async {
    setState(() {
      _checkedIngredients[name] = isChecked;
    });
    await CheckedIngredientsManager.saveCheckedIngredients(
      _checkedIngredients.entries.map((e) => CheckedIngredient(name: e.key, isChecked: e.value)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = calculateTotalIngredients(widget.weekPlan);

    return Scaffold(
      appBar: AppBar(
        title: Text('買い物リスト'),
      ),
      body: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          final isChecked = _checkedIngredients[ingredient.name] ?? false;

          return CheckboxListTile(
            title: Text('${ingredient.name} (${ingredient.quantity} ${ingredient.unit})'),
            value: isChecked,
            onChanged: (bool? value) {
              if (value != null) {
                _toggleIngredient(ingredient.name, value);
              }
            },
          );
        },
      ),
    );
  }
}
