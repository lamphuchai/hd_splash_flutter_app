import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group("Photos", () {
    testWidgets('finds hello widget', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Hello'),
        ),
      ));
      expect(find.text('Hello'), findsOneWidget);
    });
  });
}
