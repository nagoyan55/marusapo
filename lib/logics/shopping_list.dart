import 'package:myapp/models/plan.dart';
import 'package:myapp/models/ingredients.dart';

List<TotalIngredient> calculateTotalIngredients(WeekPlan weekPlan) {
  final Map<String, TotalIngredient> totalIngredients = {};

  for (final dayPlan in weekPlan.days) {
    for (final menu in [dayPlan.breakfast, dayPlan.lunch, dayPlan.dinner]) {
      for (final ingredient in menu.ingredients) {
        if (totalIngredients.containsKey(ingredient.name)) {
          totalIngredients[ingredient.name]!.addQuantity(ingredient.quantity);
        } else {
          totalIngredients[ingredient.name] = TotalIngredient(
            name: ingredient.name,
            quantity: ingredient.quantity,
            unit: ingredient.unit,
          );
        }
      }
    }
  }

  return totalIngredients.values.toList();
}
