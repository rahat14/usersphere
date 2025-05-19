import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}


class ServerException extends Equatable implements Exception {
  const ServerException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  const CacheException({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}

abstract class BaseException implements Exception {
  abstract final String? message;
}

class CommonUiException implements BaseException {
  const CommonUiException({this.message});

  @override
  final String? message;
}

class InternetConnectionException implements BaseException {
  const InternetConnectionException({this.message});

  @override
  final String? message;
}


abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException e)
      : this(message: e.message, statusCode: e.statusCode);
}


typedef ResultFuture<T> = Future<Either<Failure, T>>;