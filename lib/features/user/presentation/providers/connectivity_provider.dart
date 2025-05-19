import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final connectivityStatusProvider = StateNotifierProvider<ConnectivityNotifier, bool>(
      (ref) => ConnectivityNotifier(),
);

class ConnectivityNotifier extends StateNotifier<bool> {
  final Connectivity _connectivity = Connectivity();

  ConnectivityNotifier() : super(true) {
    _init();
  }

  void _init() async {
    final result = await _connectivity.checkConnectivity();
    state = result != ConnectivityResult.none;

    _connectivity.onConnectivityChanged.listen((event) {
      state = event != ConnectivityResult.none;
    });
  }
}
