import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode Error: $message';

  @override
  List<Object> get props => [message, statusCode];
}


typedef ResultFuture<T> = Future<Either<Failure, T>>;