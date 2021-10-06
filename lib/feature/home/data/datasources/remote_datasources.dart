import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart';
import 'package:translator/core/error/exception.dart';
import 'package:translator/feature/home/data/models/translate_models.dart';
import 'package:translator/feature/home/domain/entities/translate.dart';

abstract class RemoteDataSources {
  Future<Translate> translate(String source);
}

class RemoteDataSourcesImpl implements RemoteDataSources {
  final Client client;

  RemoteDataSourcesImpl({required this.client});
  @override
  Future<Translate> translate(String source) async {
    try {
      var targetLang = 'id';
      var url =
          'https://translate.google.com/translate_a/single?client=at&dt=t&dt=ld&dt=qca&dt=rm&dt=bd&dj=1&hl=' +
              targetLang +
              '&ie=UTF-8' +
              '&oe=UTF-8&inputm=2&otf=2&iid=1dd3b944-fa62-4b55-b330-74909a99969e';
      var data = {
        'sl': 'en',
        'tl': targetLang,
        'q': source,
      };
      var response = await client.post(Uri.parse(url), body: data, headers: {
        'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
        'User-Agent':
            'AndroidTranslate/5.3.0.RC02.130475354-53000263 5.1 phone TRANSLATE_OPM5_TEST_1',
      });
      if (response.statusCode == HttpStatus.ok) {
        var data = TranslateModels.fromJsonString(response.body);
        return data.toEntity();
      } else if (response.statusCode == 302) {
        throw RecaptchaException();
      } else {
        throw NetworkException();
      }
    } catch (e) {
      rethrow;
    }
  }
}
