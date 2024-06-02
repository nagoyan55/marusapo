import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/model.dart';
import 'package:myapp/logics/plan.dart'; // plan.dart のインポート

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('プランが指定された日付を基に生成されることを確認', () async {
    DateTime testDate = DateTime(2024, 1, 1); // テスト用の日付

    // JSONファイルをメモリにロード
    String jsonString = '''
    {
      "days": [
        {
          "breakfast": {
            "name": "トーストとサラダ",
            "ingredients": []
          },
          "lunch": {
            "name": "チキンカレー",
            "ingredients": []
          },
          "dinner": {
            "name": "焼き魚定食",
            "ingredients": []
          }
        },
        {
          "breakfast": {
            "name": "シリアルと牛乳",
            "ingredients": []
          },
          "lunch": {
            "name": "サンドイッチ",
            "ingredients": []
          },
          "dinner": {
            "name": "パスタ",
            "ingredients": []
          }
        }
      ]
    }
    ''';

    WeekPlan weekPlan = await createPlanFromJson(jsonString, testDate);

    expect(weekPlan.days.length, 2); // 2日間のプランがあることを確認

    for (int i = 0; i < 2; i++) {
      DateTime expectedDate = testDate.add(Duration(days: i));
      String expectedWeekday = _getWeekdayName(expectedDate);

      expect(weekPlan.days[i].date, expectedDate);
      expect(weekPlan.days[i].weekday, expectedWeekday);
    }
  });
}

String _getWeekdayName(DateTime date) {
  switch (date.weekday) {
    case DateTime.monday:
      return '月';
    case DateTime.tuesday:
      return '火';
    case DateTime.wednesday:
      return '水';
    case DateTime.thursday:
      return '木';
    case DateTime.friday:
      return '金';
    case DateTime.saturday:
      return '土';
    case DateTime.sunday:
      return '日';
    default:
      return '';
  }
}
