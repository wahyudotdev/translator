import 'dart:io';

import 'package:translator/core/error/exception.dart';
import 'package:translator/feature/home/data/datasources/remote_datasources.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';
import 'package:translator/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:translator/feature/home/domain/repositories/translation_repository.dart';

class TranslationRepositoryImpl implements TranslationRepository {
  final RemoteDataSources remote;

  TranslationRepositoryImpl({required this.remote});

  @override
  Future<Either<Failure, Translate>> translate(String source) async {
    try {
      var result = await remote.translate(source);
      return Right(result);
    } on NetworkException {
      return Left(NetworkFailure());
    } on RecaptchaException {
      return Left(RecaptchaFailure());
    } on SocketException {
      return Left(NetworkFailure());
    }
  }
}
