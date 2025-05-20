import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usersphere/features/user/presentation/widgets/searchWidget.dart';


void main() {
  testWidgets('SearchInputField shows and clears input', (WidgetTester tester) async {
    String lastChanged = '';
    bool wasResetCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SearchInputField(
            onChanged: (value) {
              lastChanged = value;
            },
            onReset: () {
              wasResetCalled = true;
            },
          ),
        ),
      ),
    );

    // Enter text into the search field
    const inputText = 'Test Search';
    await tester.enterText(find.byType(TextField), inputText);
    await tester.pump();

    // Expect the input is reflected in the controller
    expect(find.text(inputText), findsOneWidget);

    // Tap the clear button
    await tester.tap(find.byIcon(Icons.clear));
    await tester.pump();

    // Check that reset was called
    expect(wasResetCalled, isTrue);

    // The text field should be empty
    expect(find.text(inputText), findsNothing);
  });
}
