import 'package:get/instance_manager.dart';
import 'package:http/http.dart';
import 'package:translator/feature/home/data/datasources/remote_datasources.dart';
import 'package:translator/feature/home/data/repositories/translation_repository_impl.dart';
import 'package:translator/feature/home/domain/repositories/translation_repository.dart';
import 'package:translator/feature/home/domain/usecases/get_translation.dart';
import 'package:translator/feature/home/presentation/controller/chat_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // external dependency
    Get.lazyPut(() => Client());

    // datasources
    Get.lazyPut<RemoteDataSources>(
        () => RemoteDataSourcesImpl(client: Get.find()));

    // Repositories
    Get.lazyPut<TranslationRepository>(
        () => TranslationRepositoryImpl(remote: Get.find()));

    // Usecases
    Get.lazyPut(() => GetTranslation(Get.find()));

    // Controller
    Get.lazyPut(() => ChatController());
  }
}
