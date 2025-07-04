import 'package:flutter_clean_architecture_template/src/core/base/usecase/usecase.dart';
import 'package:flutter_clean_architecture_template/src/core/config/type_defs.dart';

import '../repository/auth_repository.dart';

class SignoutUseCase extends UseCaseWithoutParams<String> {
  final AuthRepository _repo;

  SignoutUseCase(this._repo);

  @override
  ResultFuture<String> call() async => await _repo.signout();
}
