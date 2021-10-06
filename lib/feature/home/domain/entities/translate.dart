enum MessageType { source, translation }

class Translate {
  final String source;
  final String translation;
  final String sourceLang;
  final String targetLang;
  final MessageType messageType;

  Translate({
    required this.source,
    required this.translation,
    required this.sourceLang,
    required this.targetLang,
    required this.messageType,
  });
}

class InitTranslation extends Translate {
  String? sourceInit;
  String? translationInit;
  String? sourceLangInit;
  String? targetLangInit;
  MessageType? messageTypeInit;
  InitTranslation(
    this.sourceInit,
    this.translationInit,
    this.sourceLangInit,
    this.targetLangInit,
    this.messageTypeInit,
  ) : super(
          messageType: MessageType.translation,
          translation: '',
          sourceLang: 'id',
          targetLang: 'en',
          source: '',
        );
}
