import 'package:dartz/dartz.dart';
import '../models/request/add_product.dart';
import '../sources/remote/home_remote_service.dart';
import '../../domain/entity/product_entity.dart';
import '../../domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteService _homeRemoteService;

  HomeRepositoryImpl(this._homeRemoteService);
}
