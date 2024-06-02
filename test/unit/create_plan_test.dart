import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/model.dart';
import 'package:myapp/logics/plan.dart';

void main() {
  group('createPlanFromJson', () {
    test('正常にPlanを生成する', () {
      const String jsonString = '''
      {
        "days": [
          {
            "breakfast": {
              "name": "トーストとサラダ",
              "ingredients": [
                {"name": "トースト", "quantity": 1, "unit": "枚"},
                {"name": "レタス", "quantity": 1, "unit": "枚"}
              ]
            },
            "lunch": {
              "name": "チキンカレー",
              "ingredients": [
                {"name": "鶏肉", "quantity": 200, "unit": "g"},
                {"name": "玉ねぎ", "quantity": 1, "unit": "個"}
              ]
            },
            "dinner": {
              "name": "焼き魚定食",
              "ingredients": [
                {"name": "魚", "quantity": 1, "unit": "切れ"},
                {"name": "ご飯", "quantity": 1, "unit": "杯"}
              ]
            }
          },
          {
            "breakfast": {
              "name": "シリアルと牛乳",
              "ingredients": [
                {"name": "シリアル", "quantity": 50, "unit": "g"},
                {"name": "牛乳", "quantity": 200, "unit": "ml"}
              ]
            },
            "lunch": {
              "name": "サンドイッチ",
              "ingredients": [
                {"name": "食パン", "quantity": 2, "unit": "枚"},
                {"name": "ハム", "quantity": 2, "unit": "枚"}
              ]
            },
            "dinner": {
              "name": "パスタ",
              "ingredients": [
                {"name": "パスタ", "quantity": 100, "unit": "g"},
                {"name": "トマトソース", "quantity": 200, "unit": "g"}
              ]
            }
          }
        ]
      }
      ''';

      final DateTime startDate = DateTime(2023, 1, 1);
      final WeekPlan weekPlan = createPlanFromJson(jsonString, startDate);

      expect(weekPlan.days.length, 2);

      // Day 1
      final day1 = weekPlan.days[0];
      expect(day1.date, startDate);
      expect(day1.weekday, '日');
      expect(day1.breakfast.name, 'トーストとサラダ');
      expect(day1.breakfast.ingredients.length, 2);
      expect(day1.lunch.name, 'チキンカレー');
      expect(day1.lunch.ingredients.length, 2);
      expect(day1.dinner.name, '焼き魚定食');
      expect(day1.dinner.ingredients.length, 2);

      // Day 2
      final day2 = weekPlan.days[1];
      expect(day2.date, startDate.add(Duration(days: 1)));
      expect(day2.weekday, '月');
      expect(day2.breakfast.name, 'シリアルと牛乳');
      expect(day2.breakfast.ingredients.length, 2);
      expect(day2.lunch.name, 'サンドイッチ');
      expect(day2.lunch.ingredients.length, 2);
      expect(day2.dinner.name, 'パスタ');
      expect(day2.dinner.ingredients.length, 2);
    });

    test('空のPlanを生成する', () {
      const String jsonString = '''
      {
        "days": []
      }
      ''';

      final DateTime startDate = DateTime(2023, 1, 1);
      final WeekPlan weekPlan = createPlanFromJson(jsonString, startDate);

      expect(weekPlan.days.length, 0);
    });

    test('不正なJSONでエラーが発生する', () {
      const String jsonString = '''
      {
        "invalid_field": "invalid_value"
      }
      ''';

      final DateTime startDate = DateTime(2023, 1, 1);

      expect(() => createPlanFromJson(jsonString, startDate), throwsA(isA<FormatException>()));
    });

    test('部分的に欠けたデータでPlanを生成する', () {
      const String jsonString = '''
      {
        "days": [
          {
            "breakfast": {
              "name": "トーストとサラダ",
              "ingredients": [
                {"name": "トースト", "quantity": 1, "unit": "枚"},
                {"name": "レタス", "quantity": 1, "unit": "枚"}
              ]
            },
            "lunch": {
              "name": "",
              "ingredients": []
            },
            "dinner": {
              "name": "焼き魚定食",
              "ingredients": [
                {"name": "魚", "quantity": 1, "unit": "切れ"}
              ]
            }
          }
        ]
      }
      ''';

      final DateTime startDate = DateTime(2023, 1, 1);
      final WeekPlan weekPlan = createPlanFromJson(jsonString, startDate);

      expect(weekPlan.days.length, 1);

      // Day 1
      final day1 = weekPlan.days[0];
      expect(day1.date, startDate);
      expect(day1.weekday, '日');
      expect(day1.breakfast.name, 'トーストとサラダ');
      expect(day1.breakfast.ingredients.length, 2);
      expect(day1.lunch.name, '');
      expect(day1.lunch.ingredients.length, 0);
      expect(day1.dinner.name, '焼き魚定食');
      expect(day1.dinner.ingredients.length, 1);
    });

    test('日付が異なるメニューの計算が正しいことを確認', () {
      const String jsonString = '''
      {
        "days": [
          {
            "breakfast": {
              "name": "トーストとサラダ",
              "ingredients": [
                {"name": "トースト", "quantity": 1, "unit": "枚"},
                {"name": "レタス", "quantity": 1, "unit": "枚"}
              ]
            },
            "lunch": {
              "name": "",
              "ingredients": []
            },
            "dinner": {
              "name": "",
              "ingredients": []
            }
          },
          {
            "breakfast": {
              "name": "シリアルと牛乳",
              "ingredients": [
                {"name": "シリアル", "quantity": 50, "unit": "g"},
                {"name": "牛乳", "quantity": 200, "unit": "ml"}
              ]
            },
            "lunch": {
              "name": "",
              "ingredients": []
            },
            "dinner": {
              "name": "",
              "ingredients": []
            }
          }
        ]
      }
      ''';

      final DateTime startDate = DateTime(2023, 1, 1);
      final WeekPlan weekPlan = createPlanFromJson(jsonString, startDate);

      expect(weekPlan.days.length, 2);

      // Day 1
      final day1 = weekPlan.days[0];
      expect(day1.date, startDate);
      expect(day1.weekday, '日');
      expect(day1.breakfast.name, 'トーストとサラダ');
      expect(day1.breakfast.ingredients.length, 2);

      // Day 2
      final day2 = weekPlan.days[1];
      expect(day2.date, startDate.add(Duration(days: 1)));
      expect(day2.weekday, '月');
      expect(day2.breakfast.name, 'シリアルと牛乳');
      expect(day2.breakfast.ingredients.length, 2);
    });
  });
}
