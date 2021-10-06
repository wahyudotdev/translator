import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:translator/core/error/failure.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';
import 'package:translator/feature/home/domain/entities/translation_mode.dart';
import 'package:translator/feature/home/domain/usecases/get_translation.dart';

class ChatController extends GetxController {
  final _getTranslation = Get.find<GetTranslation>();
  final scrollController = ScrollController();
  final textController = TextEditingController();
  final _chats = <Translate>[].obs;
  final isLoading = false.obs;
  final _translationMode = TranslationMode.enToId.obs;
  RxList<Translate> get chats => _chats;

  @override
  void onInit() {
    super.onInit();
    _chats.add(initMessage);
  }

  void switchTranslation() {
    if (_translationMode.value == TranslationMode.enToId) {
      _chats.add(switchIdToEn);
      _translationMode.value = TranslationMode.idToEn;
    } else {
      _chats.add(switchEnToId);
      _translationMode.value = TranslationMode.enToId;
    }
  }

  void translate() async {
    isLoading.value = true;
    _chats.add(Translate(
        source: textController.text,
        translation: '',
        sourceLang: '',
        targetLang: '',
        messageType: MessageType.source));
    _chats.add(Translate(
        source: '',
        sourceLang: '',
        targetLang: '',
        messageType: MessageType.translation));
    var result = await _getTranslation(
      Params(
        sourceText: textController.text,
        souceLang:
            _translationMode.value == TranslationMode.enToId ? 'en' : 'id',
        targetLang:
            _translationMode.value == TranslationMode.enToId ? 'id' : 'en',
      ),
    );
    result.fold((failure) async {
      isLoading.value = false;
      textController.text = '';
      if (failure is NetworkFailure) {
        _chats.last = networkFailureMessage;
      }
      if (failure is RecaptchaFailure) {
        _chats.last = recapcthaMessage;
      }
    }, (data) async {
      isLoading.value = false;
      _chats.last = data;
      textController.text = '';
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}
