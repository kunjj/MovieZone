import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/repositories/auth/auth_repositories.dart';
import '../models/signup_req_params.dart';
import '../sources/auth_api.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authApi);

  final AuthApi _authApi;
  @override
  Future<Either?> signUp({required SignUpReqParams signUpReqParams}) async => await _authApi.signUp(signUpReqParams: signUpReqParams);
}
