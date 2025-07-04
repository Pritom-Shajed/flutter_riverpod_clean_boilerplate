import 'package:flutter_clean_architecture_template/src/core/base/model/api_response.dart';
import 'package:flutter_clean_architecture_template/src/core/config/type_defs.dart';

import '../../data/models/request/signin_params.dart';
import '../../data/models/request/signup_params.dart';

abstract class AuthRepository {
  ResultFuture<JSON> signin({required SigninParams params});
  ResultFuture<ApiResponse> signup({required SignupParams params});
  ResultFuture<String> signout();
}
