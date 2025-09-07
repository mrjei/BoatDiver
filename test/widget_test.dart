// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:boatdiver_login_workflow/main.dart';

void main() {
  testWidgets('App shows BoatDiver logo', (WidgetTester tester) async {
    // Build the app.
    await tester.pumpWidget(BoatDiverApp());

    // Expect to find the app name in the UI at least once.
    expect(find.text('BoatDiver'), findsWidgets);
  });
}
