import 'package:myapp/models/total_ingredient.dart';
import 'package:myapp/models/week_plan.dart';

List<TotalIngredient> calculateTotalIngredients(WeekPlan weekPlan) {
  final Map<String, TotalIngredient> totalIngredients = {};

  for (final dayPlan in weekPlan.days) {
    for (final meal in [dayPlan.menu.breakfast, dayPlan.menu.lunch, dayPlan.menu.dinner]) {
      for (final ingredient in meal.ingredients) {
        if (totalIngredients.containsKey(ingredient.name)) {
          totalIngredients[ingredient.name] = totalIngredients[ingredient.name]!.copyWith(
            quantity: totalIngredients[ingredient.name]!.quantity + ingredient.quantity,
          );
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
