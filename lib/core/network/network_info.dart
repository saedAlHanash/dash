

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl();



  @override
  Future<bool> get isConnected => getTrue;
}

Future<bool> get getTrue async => true;
