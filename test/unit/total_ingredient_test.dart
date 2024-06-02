import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/logics/shopping_list.dart';
import 'package:myapp/models/plan.dart';
import 'package:myapp/models/ingredients.dart';

void main() {
  group('calculateTotalIngredients', () {
    test('単一メニューの計算が正しいことを確認', () {
      final weekPlan = WeekPlan(
        days: [
          DayPlan(
            breakfast: Menu(
              name: 'トーストとサラダ',
              ingredients: [
                Ingredient(name: 'トースト', quantity: 1, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            lunch: Menu(name: '', ingredients: []),
            dinner: Menu(name: '', ingredients: []),
            date: DateTime.now(),
            weekday: '月',
          ),
        ],
      );

      final totalIngredients = calculateTotalIngredients(weekPlan);

      final expectedResults = {
        'トースト': TotalIngredient(name: 'トースト', quantity: 1, unit: '枚'),
        'レタス': TotalIngredient(name: 'レタス', quantity: 1, unit: '枚'),
      };

      for (final result in totalIngredients) {
        expect(result.name, expectedResults[result.name]!.name);
        expect(result.quantity, expectedResults[result.name]!.quantity);
        expect(result.unit, expectedResults[result.name]!.unit);
      }
    });

    test('複数メニューの計算が正しいことを確認', () {
      final weekPlan = WeekPlan(
        days: [
          DayPlan(
            breakfast: Menu(
              name: 'トーストとサラダ',
              ingredients: [
                Ingredient(name: 'トースト', quantity: 1, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            lunch: Menu(
              name: 'サンドイッチ',
              ingredients: [
                Ingredient(name: '食パン', quantity: 2, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            dinner: Menu(
              name: 'パスタ',
              ingredients: [
                Ingredient(name: 'パスタ', quantity: 100, unit: 'g'),
                Ingredient(name: 'トマトソース', quantity: 200, unit: 'g'),
              ],
            ),
            date: DateTime.now(),
            weekday: '月',
          ),
        ],
      );

      final totalIngredients = calculateTotalIngredients(weekPlan);

      final expectedResults = {
        'トースト': TotalIngredient(name: 'トースト', quantity: 1, unit: '枚'),
        'レタス': TotalIngredient(name: 'レタス', quantity: 2, unit: '枚'),
        '食パン': TotalIngredient(name: '食パン', quantity: 2, unit: '枚'),
        'パスタ': TotalIngredient(name: 'パスタ', quantity: 100, unit: 'g'),
        'トマトソース': TotalIngredient(name: 'トマトソース', quantity: 200, unit: 'g'),
      };

      for (final result in totalIngredients) {
        expect(result.name, expectedResults[result.name]!.name);
        expect(result.quantity, expectedResults[result.name]!.quantity);
        expect(result.unit, expectedResults[result.name]!.unit);
      }
    });

    test('空のメニューが含まれる場合の計算が正しいことを確認', () {
      final weekPlan = WeekPlan(
        days: [
          DayPlan(
            breakfast: Menu(name: '', ingredients: []),
            lunch: Menu(
              name: 'サンドイッチ',
              ingredients: [
                Ingredient(name: '食パン', quantity: 2, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            dinner: Menu(name: '', ingredients: []),
            date: DateTime.now(),
            weekday: '月',
          ),
        ],
      );

      final totalIngredients = calculateTotalIngredients(weekPlan);

      final expectedResults = {
        '食パン': TotalIngredient(name: '食パン', quantity: 2, unit: '枚'),
        'レタス': TotalIngredient(name: 'レタス', quantity: 1, unit: '枚'),
      };

      for (final result in totalIngredients) {
        expect(result.name, expectedResults[result.name]!.name);
        expect(result.quantity, expectedResults[result.name]!.quantity);
        expect(result.unit, expectedResults[result.name]!.unit);
      }
    });

    test('日付が異なるメニューの計算が正しいことを確認', () {
      final weekPlan = WeekPlan(
        days: [
          DayPlan(
            breakfast: Menu(
              name: 'トーストとサラダ',
              ingredients: [
                Ingredient(name: 'トースト', quantity: 1, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            lunch: Menu(name: '', ingredients: []),
            dinner: Menu(name: '', ingredients: []),
            date: DateTime.now(),
            weekday: '月',
          ),
          DayPlan(
            breakfast: Menu(
              name: 'シリアルと牛乳',
              ingredients: [
                Ingredient(name: 'シリアル', quantity: 50, unit: 'g'),
                Ingredient(name: '牛乳', quantity: 200, unit: 'ml'),
              ],
            ),
            lunch: Menu(name: '', ingredients: []),
            dinner: Menu(name: '', ingredients: []),
            date: DateTime.now().add(Duration(days: 1)),
            weekday: '火',
          ),
        ],
      );

      final totalIngredients = calculateTotalIngredients(weekPlan);

      final expectedResults = {
        'トースト': TotalIngredient(name: 'トースト', quantity: 1, unit: '枚'),
        'レタス': TotalIngredient(name: 'レタス', quantity: 1, unit: '枚'),
        'シリアル': TotalIngredient(name: 'シリアル', quantity: 50, unit: 'g'),
        '牛乳': TotalIngredient(name: '牛乳', quantity: 200, unit: 'ml'),
      };

      for (final result in totalIngredients) {
        expect(result.name, expectedResults[result.name]!.name);
        expect(result.quantity, expectedResults[result.name]!.quantity);
        expect(result.unit, expectedResults[result.name]!.unit);
      }
    });

    test('空のWeekPlanの計算が正しいことを確認', () {
      final weekPlan = WeekPlan(days: []);

      final totalIngredients = calculateTotalIngredients(weekPlan);

      expect(totalIngredients, isEmpty);
    });

    test('同じ材料が複数回出てくる場合の計算が正しいことを確認', () {
      final weekPlan = WeekPlan(
        days: [
          DayPlan(
            breakfast: Menu(
              name: 'トーストとサラダ',
              ingredients: [
                Ingredient(name: 'トースト', quantity: 1, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            lunch: Menu(
              name: 'サンドイッチ',
              ingredients: [
                Ingredient(name: 'トースト', quantity: 1, unit: '枚'),
                Ingredient(name: 'レタス', quantity: 1, unit: '枚'),
              ],
            ),
            dinner: Menu(name: '', ingredients: []),
            date: DateTime.now(),
            weekday: '月',
          ),
        ],
      );

      final totalIngredients = calculateTotalIngredients(weekPlan);

      final expectedResults = {
        'トースト': TotalIngredient(name: 'トースト', quantity: 2, unit: '枚'),
        'レタス': TotalIngredient(name: 'レタス', quantity: 2, unit: '枚'),
      };

      for (final result in totalIngredients) {
        expect(result.name, expectedResults[result.name]!.name);
        expect(result.quantity, expectedResults[result.name]!.quantity);
        expect(result.unit, expectedResults[result.name]!.unit);
      }
    });
  });
}
