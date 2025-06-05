import 'package:dartz/dartz.dart';

import '../../../../data/auth/models/signup_req_params.dart';

abstract interface class AuthRepository {
  Future<Either?> signUp({required SignUpReqParams signUpReqParams});
}
