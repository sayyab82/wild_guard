// test/passive_track_screen_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wild_guard/screens/passive_track_screen.dart'; // Correct import path
// Correct import path
// Ensure this import is correct

void main() {
  testWidgets('PassiveTrackScreen widget test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(MaterialApp(home: PassiveTrackScreen()));

    // Tap on the "GO" button
    await tester.tap(find.byKey(Key('goButton')));
    await tester.pump(); // Rebuild the widget after the interaction

    // Tap on the camera link
    await tester.tap(find.byKey(Key('cameraButton')));
    await tester.pump(); // Rebuild after interaction

    // Tap on the back button
    await tester.tap(find.byKey(Key('backButton')));
    await tester.pump(); // Rebuild after interaction

    // Verify if the test passed (or failed based on your needs)
    expect(find.text('P-Track'), findsOneWidget);
  });
}
