import 'package:flutter/material.dart';
import 'package:myapp/models/week_plan.dart';
import 'package:myapp/models/checked_ingredient.dart';
import 'package:myapp/util/checked_ingredients_manager.dart';
import 'package:myapp/logics/ingredient.dart';

class ShoppingListScreen extends StatefulWidget {
  final WeekPlan weekPlan;

  ShoppingListScreen({required this.weekPlan});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  late List<CheckedIngredient> _checkedIngredients = [];

  @override
  void initState() {
    super.initState();
    _loadCheckedIngredients();
  }

  Future<void> _loadCheckedIngredients() async {
    _checkedIngredients = await CheckedIngredientsManager.loadCheckedIngredients();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final totalIngredients = calculateTotalIngredients(widget.weekPlan);

    return Scaffold(
      appBar: AppBar(
        title: Text('買い物リスト'),
      ),
      body: ListView.builder(
        itemCount: totalIngredients.length,
        itemBuilder: (context, index) {
          final ingredient = totalIngredients[index];
          final isChecked = _checkedIngredients
              .any((checkedIngredient) => checkedIngredient.name == ingredient.name && checkedIngredient.isChecked);

          return CheckboxListTile(
            title: Text('${ingredient.name} - ${ingredient.quantity} ${ingredient.unit}'),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                if (value == true) {
                  _checkedIngredients.add(CheckedIngredient(name: ingredient.name, isChecked: true));
                } else {
                  _checkedIngredients.removeWhere((checkedIngredient) => checkedIngredient.name == ingredient.name);
                }
                CheckedIngredientsManager.saveCheckedIngredients(_checkedIngredients);
              });
            },
          );
        },
      ),
    );
  }
}
