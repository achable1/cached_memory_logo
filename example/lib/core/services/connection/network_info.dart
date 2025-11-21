import "package:internet_connection_checker_plus/internet_connection_checker_plus.dart";

/// An abstract class that provides the network information
abstract class NetworkInfo {
  /// Returns a [Future] of [bool] that indicates
  /// if the device is connected to the internet
  Future<bool> get isConnected;
}

/// A class that implements the [NetworkInfo] abstract class
class NetworkInfoImpl implements NetworkInfo {
  /// Initializes the [NetworkInfoImpl] with the [connectionChecker]
  NetworkInfoImpl(this.connectionChecker);

  /// A class that checks the internet connection
  final InternetConnection connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasInternetAccess;
}
