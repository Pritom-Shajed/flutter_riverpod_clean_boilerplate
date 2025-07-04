import 'package:flutter_clean_architecture_template/src/core/base/model/api_response.dart';
import 'package:flutter_clean_architecture_template/src/core/base/usecase/usecase.dart';
import 'package:flutter_clean_architecture_template/src/core/config/type_defs.dart';

import '../../data/models/request/signup_params.dart';
import '../repository/auth_repository.dart';

class SignupUseCase extends UseCaseWithParams<ApiResponse, SignupParams> {
  final AuthRepository _repo;

  SignupUseCase(this._repo);

  @override
  ResultFuture<ApiResponse> call(SignupParams params) async =>
      await _repo.signup(params: params);
}
