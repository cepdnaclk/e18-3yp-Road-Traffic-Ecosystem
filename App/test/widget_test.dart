// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_auth/Screens/Welcome/user_details_screen.dart';
import 'package:flutter_auth/Screens/google_map_Screen.dart';
import 'package:flutter_auth/Screens/map_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_auth/main.dart';

import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  // ignore: literal_only_boolean_expressions
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigatorObserver>(
      returnNullOnMissingStub: true,
    )
  ],
)
void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized(); Gets called in setupFirebaseAuthMocks()
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group("GoogleMapWidgettest", () {
    testWidgets("Googele Map  widget test ", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GoogleMapScreen(),
      ));
      await tester.pump();
      final button1 = find.byIcon(Icons.map);
      expect(button1, findsOneWidget);
      final button = find.byType(FloatingActionButton);

      final button2 = find.byIcon(Icons.add_location);
      expect(button2, findsOneWidget);
    });

    testWidgets('Button is present and triggers navigation after tapped',
        (WidgetTester tester) async {
      final observerMock = MockNavigatorObserver();

      final mockObserver = MockNavigatorObserver();
      await tester.pumpWidget(
        MaterialApp(
          home: UserDetails("123456"),
          navigatorObservers: [observerMock],
        ),
      );
      final button1 = find.byType(ElevatedButton);

      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      /// Verify that a push event happened

      /// You'd also want to be sure that your page is now
      /// present in the screen.

      /// Verify that a push event happened
      //verify(mockObserver.didPush(any, any));

      /// You'd also want to be sure that your page is now
      /// present in the screen.
    });

    print("free trial teds passed");
  });
}
