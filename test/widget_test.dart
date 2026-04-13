// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:personal_portfolio/main.dart';

void main() {
  testWidgets('Portfolio shows name and projects', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.textContaining('Franklin'), findsWidgets);
    expect(find.text('Pro Track'), findsOneWidget);
    expect(find.text('Canopy'), findsOneWidget);
    expect(find.text('Certifications'), findsOneWidget);
    expect(find.text('Based Build IRL Workshop'), findsOneWidget);
  });
}
