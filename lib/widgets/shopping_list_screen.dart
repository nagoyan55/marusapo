import 'package:flutter/material.dart';
import 'package:myapp/models/shopping_list.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<TotalIngredient> totalIngredients;

  ShoppingListScreen({required this.totalIngredients});

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final Map<String, bool> _checkedItems = {};

  @override
  void initState() {
    super.initState();
    for (var ingredient in widget.totalIngredients) {
      _checkedItems[ingredient.name] = false;
    }
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
          return CheckboxListTile(
            title: Text(ingredient.name),
            subtitle: Text('${ingredient.quantity} ${ingredient.unit}'),
            value: _checkedItems[ingredient.name],
            onChanged: (bool? value) {
              setState(() {
                _checkedItems[ingredient.name] = value ?? false;
              });
            },
          );
        },
      ),
    );
  }
}
