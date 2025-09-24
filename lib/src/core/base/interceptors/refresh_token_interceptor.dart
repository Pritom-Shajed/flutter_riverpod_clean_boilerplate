import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture_template/src/core/base/api_client.dart';

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor({required this.dio, required this.apiClient});

  final Dio dio;
  final ApiClient apiClient;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // // Handle 401 Unauthorized errors.
    // // For all other errors, pass them along.
    // if (err.response?.statusCode != 401) {
    //   return handler.next(err);
    // }

    // log.w('Intercepted a 401 Unauthorized error. Attempting to refresh token...');

    // try {
    //   // Call the existing fetchToken method from your ApiClient.
    //   final tokenResult = await apiClient.fetchToken();

    //   await tokenResult.fold(
    //     (failure) async {
    //       // If token refresh fails, sign the user out and reject the request
    //       // with the original 401 error.
    //       log.e('Token refresh failed: ${failure.message}. Signing out.');
    //       await apiClient.signout();
    //       handler.next(err);
    //     },
    //     (newToken) async {
    //       // If token refresh is successful, retry the original request.
    //       log.i('Token refresh successful. Retrying the original request.');

    //       final requestOptions = err.requestOptions;
    //       // Update the authorization header with the new token.
    //       requestOptions.headers[HttpHeaders.authorizationHeader] = 'Bearer $newToken';

    //       // Retry the request using dio.fetch, which is designed for this.
    //       // It will return a new response or throw a new error.
    //       final response = await dio.fetch(requestOptions);

    //       // Resolve the handler with the new, successful response.
    //       // This completes the request cycle for the original caller.
    //       handler.resolve(response);
    //     },
    //   );
    // } catch (e) {
    //   log.e('An unexpected error occurred in RefreshTokenInterceptor: $e');
    //   // If any other unexpected error happens, pass the original error along.
    //   handler.next(err);
    // }
  }
}
