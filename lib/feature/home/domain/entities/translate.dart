enum MessageType { source, translation }

class Translate {
  final String source;
  final String? translation;
  final String sourceLang;
  final String targetLang;
  final MessageType messageType;

  Translate({
    required this.source,
    this.translation,
    required this.sourceLang,
    required this.targetLang,
    required this.messageType,
  });
}

final networkFailureMessage = Translate(
    source: '',
    translation: 'Network failure :( , check your internet\'s connection',
    sourceLang: '',
    targetLang: '',
    messageType: MessageType.translation);

final recapcthaMessage = Translate(
    source: '',
    translation: 'Please reconnect with new IP',
    sourceLang: '',
    targetLang: '',
    messageType: MessageType.translation);
final initMessage = Translate(
    source: '',
    translation:
        'Type something in english, i will translate in Indonesian for you :)',
    sourceLang: '',
    targetLang: '',
    messageType: MessageType.translation);
