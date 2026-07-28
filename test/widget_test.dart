import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_shop_mobile/main.dart';

void main() {

  tearDown(() async {
    await TestWidgetsFlutterBinding.ensureInitialized().runAsync(() async {});
  });

  testWidgets('shows the home screen correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const AmoraDaffodilsApp());
    await tester.pump();

    expect(find.text('Trending Flowers'), findsOneWidget);
    expect(find.text('Search flowers here'), findsOneWidget);
    expect(find.text('View All'), findsOneWidget);
  });

  testWidgets('filters flowers in place when searching from the home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const AmoraDaffodilsApp());
    await tester.pump();

    final searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);

    await tester.enterText(searchField, 'rose');
    await tester.pump();

    expect(find.text('Red Rose'), findsOneWidget);
    expect(find.text('Daisy'), findsNothing);
  });
}