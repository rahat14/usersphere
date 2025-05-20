import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usersphere/features/user/presentation/widgets/noInternetWidget.dart';


void main() {
  testWidgets('NoInternetWidget shows icon, text, and calls onRetry on tap', (WidgetTester tester) async {
    bool retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoInternetWidget(
            onRetry: () {
              retried = true;
            },
          ),
        ),
      ),
    );

    // Verify icon is displayed
    expect(find.byIcon(Icons.wifi_off), findsOneWidget);

    // Verify main text
    expect(find.text('No Internet Connection'), findsOneWidget);

    // Verify instruction text
    expect(
      find.textContaining('Please make sure you are connected'),
      findsOneWidget,
    );

    // Tap Retry button
    await tester.tap(find.text('Retry'));
    await tester.pump();

    // Verify callback fired
    expect(retried, isTrue);
  });
}
