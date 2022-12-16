import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/google_map_Screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("GoogleMapWidgettest", () {
    testWidgets("free trial tedst", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GoogleMapScreen(),
      ));
      await tester.pump();
      final button1 = find.byIcon(Icons.map);
      expect(button1, findsOneWidget);
      final button = find.byType(FloatingActionButton);

      final button2 = find.byIcon(Icons.add_location);
      expect(button2, findsNothing);
      expect(button, findsNWidgets(3));
    });
  });
}
