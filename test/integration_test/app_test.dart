import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapp/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ユーザーが買い物リストまで確認する', (WidgetTester tester) async {
    // アプリを起動
    await tester.pumpWidget(MyApp());

    // プランを生成ボタンを探してタップ
    final generatePlanButton = find.text('プランを生成');
    expect(generatePlanButton, findsOneWidget);
    await tester.tap(generatePlanButton);
    await tester.pumpAndSettle();

    // 買い物リストボタンを探してタップ
    final shoppingListButton = find.text('買い物リスト');
    expect(shoppingListButton, findsOneWidget);
    await tester.tap(shoppingListButton);
    await tester.pumpAndSettle();

    // 買い物リストが表示されることを確認
    final shoppingListTitle = find.text('買い物リスト');
    expect(shoppingListTitle, findsOneWidget);

    // 具体的な買い物リストの項目を確認
    final ingredient1 = find.text('トースト');
    final ingredient2 = find.text('レタス');
    expect(ingredient1, findsOneWidget);
    expect(ingredient2, findsOneWidget);
  });
}
