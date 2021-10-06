import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';
import 'package:translator/feature/home/domain/usecases/get_translation.dart';

class ChatController extends GetxController {
  final _getTranslation = Get.find<GetTranslation>();
  final scrollController = ScrollController();
  final textController = TextEditingController();
  final _chats = <Translate>[].obs;
  final isLoading = false.obs;
  RxList<Translate> get chats => _chats;

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
        translation: '',
        sourceLang: '',
        targetLang: '',
        messageType: MessageType.translation));
    var result = await _getTranslation(Params(sourceText: textController.text));
    result.fold((failure) async {
      isLoading.value = false;
      _chats.removeLast();
      textController.text = '';
    }, (data) async {
      isLoading.value = false;
      _chats.last = data;
      textController.text = '';
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }
}
