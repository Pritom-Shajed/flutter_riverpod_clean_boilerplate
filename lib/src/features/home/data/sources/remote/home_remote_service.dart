import 'package:flutter_clean_architecture_template/src/core/base/api_client.dart';

abstract class HomeRemoteService {}

class HomeRemoteServiceImpl implements HomeRemoteService {
  final ApiClient _apiClient;

  HomeRemoteServiceImpl(this._apiClient);
}
