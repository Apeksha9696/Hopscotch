import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hopscotch_homepage/main.dart';

void main() {
  testWidgets('HopscotchApp renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const HopscotchApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
