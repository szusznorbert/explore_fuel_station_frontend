import 'package:dio/dio.dart';
import 'package:explore_fuel_stations/core/common/env.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio backendDio;

  DioClient._internal() {
    backendDio = Dio(
      BaseOptions(
        baseUrl: Environment.serverUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 5),
        headers: {'authorization': Environment.apiKey},
        validateStatus: (status) => status != null && (status >= 200 && status < 300),
      ),
    );
  }
}
