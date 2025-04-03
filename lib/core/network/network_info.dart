import 'package:internet_connection_checker/internet_connection_checker.dart';

// Abstract class for network checking
// Using abstract class allows for different implementations
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

// Implementation using InternetConnectionChecker
// Could use Connectivity package instead, but InternetConnectionChecker is more reliable
class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker internetConnectionChecker;

  NetworkInfoImpl(this.internetConnectionChecker);

  @override
  // Simple delegation to the checker
  Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}