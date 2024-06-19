class ServerException implements Exception {}

class CacheException implements Exception {}

class DataNotFoundException implements Exception {
  final String errorMessage;
  DataNotFoundException({required this.errorMessage});
}

class UnauthorizedException implements Exception{}