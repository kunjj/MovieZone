import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../core/usecase/usecase.dart';
import '../../../data/auth/models/signup_req_params.dart';
import '../repositories/auth/auth_repositories.dart';

@lazySingleton
class SignUpUseCase implements UseCase<Future<Either?>, SignUpReqParams> {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  @override
  Future<Either?> call(SignUpReqParams params) async => await _authRepository.signUp(signUpReqParams: params);
}
