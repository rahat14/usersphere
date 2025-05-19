import 'package:dio/dio.dart';

import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/network_exceptions.dart';

class UserApiService {
  final Dio _dio;

  UserApiService(this._dio);

  Future<Response> fetchUsers(int page) async {
    try {
      final response = await _dio.get('/users', queryParameters: {'per_page': 10, 'page': page});

      if (response.statusCode == 200) {
        return response;
      } else {
        throw ServerException(message:  'Failed to load users' , statusCode:  response.statusCode ?? 00);
      }
    } on DioException catch (ex) {
      throw CustomException.fromDioException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }
}
