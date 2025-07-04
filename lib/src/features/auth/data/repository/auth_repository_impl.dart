import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_template/src/core/base/model/api_response.dart';
import 'package:flutter_clean_architecture_template/src/core/config/type_defs.dart';
import 'package:flutter_clean_architecture_template/src/features/auth/data/models/request/signin_params.dart';
import 'package:flutter_clean_architecture_template/src/features/auth/data/models/request/signup_params.dart';
import 'package:flutter_clean_architecture_template/src/features/auth/data/sources/remote/auth_remote_service.dart';
import 'package:flutter_clean_architecture_template/src/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteService _authRemoteService;

  AuthRepositoryImpl(this._authRemoteService);

  @override
  ResultFuture<JSON> signin({required SigninParams params}) async {
    final response = await _authRemoteService.signin(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  ResultFuture<ApiResponse> signup({required SignupParams params}) async {
    final response = await _authRemoteService.signup(params: params);
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }

  @override
  ResultFuture<String> signout() async {
    final response = await _authRemoteService.signout();
    return response.fold(
      (error) => Left(error),
      (success) => Right(success),
    );
  }
}
