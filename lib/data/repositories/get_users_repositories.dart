import 'package:dio/dio.dart';

import 'package:random_users_app/core/network/dio_settings.dart';
import 'package:random_users_app/data/models/users_data_model.dart';
import 'package:random_users_app/data/models/users_params_model.dart';

class GetUsersRepositories {
  final Dio dio = DioSettings().dio;
  Future<UsersDataModel> getUsers({required UsersParamsModel model}) async {
    final Response response = await dio.get(
      '',
      queryParameters: model.toJson(),
    );
    return UsersDataModel.fromJson(response.data);
  }
}
