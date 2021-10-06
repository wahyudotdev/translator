import 'package:translator/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:translator/core/usecases/usecases.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';
import 'package:translator/feature/home/domain/repositories/translation_repository.dart';

class GetTranslation implements UseCase<Translate, Params> {
  final TranslationRepository _repository;

  GetTranslation(this._repository);

  @override
  Future<Either<Failure, Translate>> call(Params params) async {
    return await _repository.translate(params.sourceText);
  }
}

class Params {
  final String sourceText;

  Params({required this.sourceText});
}
