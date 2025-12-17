import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    _instance ??= NetworkManager._internal();
    return _instance!;
  }

  NetworkManager._internal();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final List<ConnectivityResult> _connectionStatus = [];

  /// Initialize the network manager and set up a stream to continually check the connection status.
  void onInit() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  /// Update the connection status based on changes in connectivity.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.clear();
    _connectionStatus.addAll(result);
    // Note: Cannot show toast here as BuildContext is not available in stream listener
    // Check connection status using isConnected() method where BuildContext is available
  }

  /// Check the internet connection status.
  /// Returns `true` if connected, `false` otherwise.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.any((element) => element == ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Dispose or close the active connectivity stream.
  void dispose() {
    _connectivitySubscription.cancel();
  }
}
