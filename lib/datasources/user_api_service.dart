import 'package:dio/dio.dart';

import '../core/constants/Constants.dart';
import '../core/network/api_exceptions.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(this._dio);



  Future<Response> fetchUsers(int page) async {
    try {
      final response = await _dio.get('/users', queryParameters: {
        'per_page': 10,
        'page': page,
      });

      if (response.statusCode == 200) {
        return response ;
      } else {
        throw ServerException('Failed to load users');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException();
      } else if (e.response != null) {
        throw ServerException(e.response?.data['error'] ?? 'Unexpected error occurred');
      } else {
        throw ApiException('An error occurred: ${e.message}');
      }
    } catch (e) {
      throw ApiException(e.toString());
    }
  }
}
