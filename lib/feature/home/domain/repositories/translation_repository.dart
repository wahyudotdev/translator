import 'package:dartz/dartz.dart';
import 'package:translator/core/error/failure.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';

abstract class TranslationRepository {
  Future<Either<Failure, Translate>> translate(String text);
}
