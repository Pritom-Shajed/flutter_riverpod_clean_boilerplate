import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/core/base/failure/failure.dart';

typedef DataMap = Map<String, dynamic>;
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef JSON = Map<String, dynamic>;
typedef QueryParams = Map<String, String>;
