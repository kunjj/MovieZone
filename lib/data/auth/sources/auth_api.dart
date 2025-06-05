import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constants/api_url.dart';
import '../../../core/network/dio_client.dart';
import '../models/signup_req_params.dart';

@lazySingleton
class AuthApi {
  AuthApi(this._dioClient);

  final DioClient _dioClient;

  Future<Either?> signUp({required SignUpReqParams signUpReqParams}) async {
    try {
      await _dioClient.post(ApiUrl.signUp, data: signUpReqParams.toJson()).then((response) => Right(response.data));
    } on DioException catch (error) {
      return Left(error.response!.data['message']);
    }
    return null;
  }
}
