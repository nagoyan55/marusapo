import 'package:flutter/material.dart';
import 'package:myapp/models/ingredients.dart';
import 'package:myapp/util/checked_ingredients_manager.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<TotalIngredient> totalIngredients;

  ShoppingListScreen({required this.totalIngredients});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<CheckedIngredient> _checkedIngredients = [];

  @override
  void initState() {
    super.initState();
    _loadCheckedIngredients();
  }

  Future<void> _loadCheckedIngredients() async {
    final loadedCheckedIngredients =
        await CheckedIngredientsManager.loadCheckedIngredients();
    setState(() {
      if (loadedCheckedIngredients.isNotEmpty) {
        _checkedIngredients = loadedCheckedIngredients;
      } else {
        _checkedIngredients = widget.totalIngredients
            .map((ingredient) => CheckedIngredient(name: ingredient.name))
            .toList();
      }
    });
  }

  Future<void> _saveCheckedIngredients() async {
    await CheckedIngredientsManager.saveCheckedIngredients(_checkedIngredients);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('買い物リスト'),
      ),
      body: ListView.separated(
        itemCount: widget.totalIngredients.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final ingredient = widget.totalIngredients[index];
          final checkedIngredient = _checkedIngredients
              .firstWhere((element) => element.name == ingredient.name);

          return CheckboxListTile(
            title: Text(ingredient.name),
            subtitle: Text('${ingredient.quantity} ${ingredient.unit}'),
            value: checkedIngredient.isChecked,
            onChanged: (bool? value) {
              setState(() {
                checkedIngredient.isChecked = value ?? false;
                _saveCheckedIngredients();
              });
            },
          );
        },
      ),
    );
  }
}
