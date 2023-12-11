import 'package:dartz/dartz.dart';
import 'package:flutter_task/core/error/failure.dart';
import 'package:flutter_task/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';

abstract class BaseRepository {
  Future<Either<Map<String, dynamic>, Failure>> loginWithEmailAndPassword(
      AuthModel authModel);
}