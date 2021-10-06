import 'dart:convert';

import 'package:translator/feature/home/domain/entities/translate.dart';

class TranslateModels extends Translate {
  final String sourceModel;
  final String translationModel;
  final String sourceLangModel;
  final String targetLangModel;
  final MessageType messageTypeModel;

  TranslateModels(this.sourceModel, this.translationModel, this.sourceLangModel,
      this.targetLangModel, this.messageTypeModel)
      : super(
          source: sourceModel,
          translation: translationModel,
          sourceLang: sourceLangModel,
          targetLang: targetLangModel,
          messageType: messageTypeModel,
        );

  factory TranslateModels.fromJsonString(String jsonString) {
    var object = json.decode(jsonString);
    return TranslateModels(object['sentences'][0]['orig'],
        object['sentences'][0]['trans'], 'id', 'en', MessageType.translation);
  }

  Translate toEntity() {
    return Translate(
      source: sourceModel,
      translation: translationModel,
      sourceLang: sourceLangModel,
      targetLang: targetLangModel,
      messageType: messageTypeModel,
    );
  }
}
