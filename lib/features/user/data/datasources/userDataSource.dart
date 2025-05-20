import 'package:dio/dio.dart';

import '../../../../core/network/network_exceptions.dart';
import '../models/UserListResp.dart';

class UserDataSource {
  final Dio _dio;

  UserDataSource(this._dio);

  Future<UserListResp> fetchUsers(int page) async {
    try {
      final response = await _dio.get('/users', queryParameters: {'per_page': 10, 'page': page});

      if (response.statusCode.toString().startsWith("20")) {
        var p = userListRespFromJson(response.toString());
        return p;
      } else {
        throw CustomException.statusCodeError(response.statusCode ?? 00);
      }
    } on DioException catch (ex) {
      throw CustomException.fromDioException(ex);
    } on Exception catch (ex) {
      throw CustomException.fromParsingException(ex);
    }
  }
}
