import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('プラン生成画面の表示を確認する', (WidgetTester tester) async {
    // 共有データをクリア
    SharedPreferences.setMockInitialValues({});

    // アプリを起動
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(); // アプリの初期状態を待つ

    // プランを生成ボタンを探してタップ
    final generatePlanButton = find.text('プランを生成');
    expect(generatePlanButton, findsOneWidget);
    await tester.tap(generatePlanButton);
    await tester.pumpAndSettle(); // プラン生成画面が表示されるのを待つ

    // プラン生成画面が表示されることを確認
    final planScreenTitle = find.text('こんだてまるさぽくん');
    expect(planScreenTitle, findsOneWidget);
  });
}
