import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/home_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/google_map_Screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Home Screen test", () {
    testWidgets("Navigations in Home screen checked",
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: HomeScreen(),
      ));
      await tester.pump();
      var signInButton = find.text("Feature 3");

      expect(signInButton, findsNothing);
    });
  });
}
