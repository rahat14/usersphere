import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:usersphere/features/user/data/models/UserListResp.dart';
import 'package:usersphere/features/user/presentation/screens/UserDetailsScreen.dart';
import 'package:usersphere/features/user/presentation/widgets/cachedCircleAvatar.dart';

var FakeUser = User(
  id: 1,
  email: 'george.bluth@reqres.in',
  firstName: 'George',
  lastName: 'Bluth',
  avatar: 'https://reqres.in/img/faces/1-image.jpg',
);

void main() {
  testWidgets('UserDetailsScreen displays user info', (WidgetTester tester) async {
    var user = FakeUser ;

    await tester.pumpWidget(
      MaterialApp(
        home: UserDetailsScreen(user: user),
      ),
    );

    // Check app bar title
    expect(find.text('User Details'), findsOneWidget);

    // Check full name
    expect(find.text('George Bluth'), findsWidgets); // title and card

    // Check email
    expect(find.text('george.bluth@reqres.in'), findsOneWidget);

    // Check avatar by CachedCircleAvatar
    expect(find.byType(CachedCircleAvatar), findsOneWidget);

    // Check list tile subtitles
    expect(find.text('Full Name'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
  });
}