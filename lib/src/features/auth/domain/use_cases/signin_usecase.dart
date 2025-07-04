import 'package:flutter_clean_architecture_template/src/core/base/usecase/usecase.dart';
import 'package:flutter_clean_architecture_template/src/core/config/type_defs.dart';

import '../../data/models/request/signin_params.dart';
import '../repository/auth_repository.dart';

class SigninUseCase extends UseCaseWithParams<JSON, SigninParams> {
  final AuthRepository _repo;

  SigninUseCase(this._repo);

  @override
  ResultFuture<JSON> call(SigninParams params) async =>
      await _repo.signin(params: params);
}
