import 'package:myapp/models/week_plan.dart';

WeekPlan getWeekPlan() {
  final json = {
    "days": [
      {
        "date": "2023-01-01",
        "weekday": "日",
        "menu": {
          "breakfast": {
            "name": "朝食",
            "ingredients": [
              {"name": "卵", "quantity": 2, "unit": "個"},
              {"name": "牛乳", "quantity": 200, "unit": "ml"}
            ],
            "recipe": {"description": "卵を焼いて、牛乳を飲む"}
          },
          "lunch": {
            "name": "昼食",
            "ingredients": [
              {"name": "鶏肉", "quantity": 300, "unit": "g"},
              {"name": "野菜", "quantity": 150, "unit": "g"}
            ],
            "recipe": {"description": "鶏肉を焼いて、野菜を添える"}
          },
          "dinner": {
            "name": "夕食",
            "ingredients": [
              {"name": "卵", "quantity": 1, "unit": "個"},
              {"name": "ご飯", "quantity": 1, "unit": "杯"}
            ],
            "recipe": {"description": "卵焼きを作って、ご飯と一緒に食べる"}
          }
        }
      },
      {
        "date": "2023-01-02",
        "weekday": "月",
        "menu": {
          "breakfast": {
            "name": "朝食",
            "ingredients": [
              {"name": "パン", "quantity": 2, "unit": "枚"},
              {"name": "バター", "quantity": 10, "unit": "g"}
            ],
            "recipe": {"description": "パンにバターを塗って食べる"}
          },
          "lunch": {
            "name": "昼食",
            "ingredients": [
              {"name": "豚肉", "quantity": 200, "unit": "g"},
              {"name": "キャベツ", "quantity": 100, "unit": "g"}
            ],
            "recipe": {"description": "豚肉とキャベツを炒める"}
          },
          "dinner": {
            "name": "夕食",
            "ingredients": [
              {"name": "魚", "quantity": 1, "unit": "切れ"},
              {"name": "ご飯", "quantity": 1, "unit": "杯"}
            ],
            "recipe": {"description": "魚を焼いて、ご飯と一緒に食べる"}
          }
        }
      }
    ]
  };

  final weekPlan = WeekPlan.fromJson(json);
  return weekPlan;
}

void main() async {
  final weekPlan = await getWeekPlan();
  print(weekPlan);
}
