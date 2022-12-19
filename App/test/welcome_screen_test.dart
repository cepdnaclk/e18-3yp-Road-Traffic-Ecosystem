import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/google_map_Screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Wecome Screen test", () {
    testWidgets("Check the buttons in welcome screen", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WelcomeScreen(),
      ));
      await tester.pump();
      final button1 = find.byIcon(Icons.map);
      expect(button1, findsNothing);
      final button = find.byType(FloatingActionButton);

      final button2 = find.byIcon(Icons.add_location);
      expect(button2, findsNothing);


    var signInButton = find.text("SIGN UP");
    expect(signInButton, findsOneWidget);


    var loginInButton = find.text("LOGIN");
    expect(loginInButton, findsOneWidget);
      
    });
  });
}
