import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/src/core/utils/toasts/app_toasts.dart';
import '../../../../core/router/go_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injector.dart';
import '../../data/models/request/signin_params.dart';
import '../../data/models/request/signup_params.dart';
import '../../domain/use_cases/sign_out_usecase.dart';
import '../../domain/use_cases/signin_usecase.dart';
import '../../domain/use_cases/signup_usecase.dart';

typedef AuthNotifier = NotifierProvider<AuthProvider, void>;

final authProvider = AuthNotifier(AuthProvider.new);

class AuthProvider extends Notifier {
  // Use cases
  final _signInUseCase = sl<SigninUseCase>();
  final _signUpUseCase = sl<SignupUseCase>();
  final _signOutUseCase = sl<SignoutUseCase>();

  final signinFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;

  @override
  void build() {
    nameController.text = 'John Doe';
    emailController.text = 'john@mail.com';
    passwordController.text = 'changeme';
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    ref.notifyListeners();
  }

  Future<void> signin(BuildContext context) async {
    if (!(signinFormKey.currentState?.validate() ?? false)) return;
    isLoading = true;
    ref.notifyListeners();
    //
    final response = await _signInUseCase(
      SigninParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
        AppToasts.longToast(error.toString());
      },
      (success) async {
        isLoading = false;
        ref.notifyListeners();
        goRouter.refresh();
      },
    );
  }

  Future<void> signup(BuildContext context) async {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;
    isLoading = true;
    ref.notifyListeners();
    //
    final response = await _signUpUseCase(
      SignupParams(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      ),
    );
    response.fold(
      (error) {
        isLoading = false;
        ref.notifyListeners();
        AppToasts.longToast(error.toString());
      },
      (success) async {
        isLoading = false;
        ref.notifyListeners();
        goRouter.refresh();
      },
    );
  }

  Future<void> signout(BuildContext context) async {
    EasyLoading.show();
    final response = await _signOutUseCase();
    EasyLoading.dismiss();
    response.fold(
      (error) => AppToasts.longToast(error.toString()),
      (success) async {
        goRouter.refresh();
      },
    );
  }
}
