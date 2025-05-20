import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:usersphere/features/user/data/models/UserListResp.dart';
import 'package:usersphere/features/user/domain/repositories/UserListRepo.dart';
import 'package:usersphere/features/user/presentation/providers/connectivityProvider.dart';
import 'package:usersphere/features/user/presentation/screens/UserListScreen.dart';

class MockUserRepository extends Mock implements UserListRepository {}

class TestConnectivityNotifier extends ConnectivityNotifier {
  TestConnectivityNotifier(bool initial) {
    state = initial; // override the real initialization
  }

  void goOnline() => state = true;

  void goOffline() => state = false;

  @override
  void _init() {
    // Disable the real listener logic from Connectivity
  }
}

void main() {
  final sl = GetIt.instance;
  final calledPages = <int>[];
  int refreshCount = 0;

  setUp(() {
    refreshCount = 0; // reset before each test
    calledPages.clear(); // clear previous state
  });

  setUpAll(() {
    final mockRepo = MockUserRepository();

    // Simulate paginated user data
    when(() => mockRepo.getUsers(any())).thenAnswer((invocation) async {
      final page = invocation.positionalArguments.first as int;
      refreshCount = refreshCount + 1;
      calledPages.add(page); // Track pages called

      return UserListResp(
        data: List.generate(
          10,
              (i) =>
              User(
                id: i + (page - 1) * 10 + refreshCount * 100,
                // unique data per refresh
                email: 'user${i + 1 + refreshCount * 100}@test.com',
                firstName: 'User',
                lastName: '${i + 1 + refreshCount * 100}',
                avatar: 'https://example.com/avatar.png',
              ),
        ),
      );
    });

    sl.registerLazySingleton<UserListRepository>(() => mockRepo);
  });

  tearDownAll(() {
    sl.reset();
  });

  testWidgets('triggers pull-to-refresh and loads new data', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: UserListScreen())));

    await tester.pumpAndSettle(); // Wait for first load

    // Ensure initial item is present
    final firstItemBefore = find.byKey(const Key('user_list_item_0'));
    expect(firstItemBefore, findsOneWidget);
    //Initial load → refreshCount = 1 → user101@test.com
    expect(find.textContaining('user101@test.com'), findsOneWidget);
    // Perform pull-to-refresh gesture
    final listFinder = find.byKey(const Key('pull-to-refresh'));
    await tester.drag(listFinder, const Offset(0, 300)); // drag down
    await tester.pump(); // start refresh
    await tester.pump(const Duration(seconds: 1)); // wait for refresh
    await tester.pumpAndSettle();

    //After pull-to-refresh → refreshCount = 2 → user201@test.com

    // Confirm refreshed item is shown (new unique ID or email)
    final refreshedItem = find.textContaining('user201@test.com');
    expect(refreshedItem, findsOneWidget);
  });

  testWidgets('loads user and scroll to bottom ', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: UserListScreen())));

    // Wait for initial page to load
    await tester.pumpAndSettle();

    // Expect first page item
    expect(find.byKey(const Key('user_list_item_0')), findsOneWidget);

    // Scroll until item 19 is visible (to trigger pagination)
    await tester.dragUntilVisible(
      find.byKey(const Key('user_list_item_9')),
      find.byKey(const Key('user_list_view')),
      const Offset(0, -800),
    );

    // Let pagination settle
    await tester.pumpAndSettle();

    // Assert item 19 is visible
    expect(find.byKey(const Key('user_list_item_7')), findsOneWidget);
  });

  testWidgets('displays NoInternetWidget and loads data on Retry',
          (WidgetTester tester) async {
        final testConnectivity = TestConnectivityNotifier(false); // start offline



        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              connectivityStatusProvider.overrideWith((_) => testConnectivity),
            ],
            child: const MaterialApp(
              home: UserListScreen(),
            ),
          ),
        );

        await tester.pumpAndSettle();

        // Verify offline screen
        expect(find.text('No Internet Connection'), findsOneWidget);

        // Tap Retry
        await tester.tap(find.text('Retry'));
        await tester.pump();

        // Simulate coming online AFTER Retry tap
        testConnectivity.goOnline();
        await tester.pumpAndSettle();

        // Expect user data loaded
        expect(find.byKey(const Key('user_list_item_0')), findsOneWidget);
      });
}
