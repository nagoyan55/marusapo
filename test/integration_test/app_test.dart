import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:myapp/main.dart'; // メインアプリファイルのインポート

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('アプリ起動テスト', (WidgetTester tester) async {
    // アプリのビルドと起動
    await tester.pumpWidget(MyApp());

    // 初期状態の確認
    expect(find.text('こんだてまるさぽくん'), findsOneWidget);
    expect(find.text('プランを生成'), findsOneWidget);

    // ボタンをタップして次の画面に遷移
    await tester.tap(find.text('プランを生成'));
    await tester.pumpAndSettle();

    // テーブルが表示されることを確認
    expect(find.byType(DataTable), findsOneWidget);
    expect(find.text('日付'), findsOneWidget);
    expect(find.text('朝食'), findsOneWidget);
    expect(find.text('昼食'), findsOneWidget);
    expect(find.text('夕食'), findsOneWidget);
  });
}
