import 'package:http/http.dart' as http;

abstract class ApiProvider {
  Future<String> get({
    required String path,
    Map<String, String>? parameters,
  });
}

class ApiProviderImpl implements ApiProvider {
  static final ApiProviderImpl _instance = ApiProviderImpl._internal();

  ApiProviderImpl._internal();

  factory ApiProviderImpl() {
    return _instance;
  }

  final _host = 'api.themoviedb.org';
  final _apiVersion = 3;
  final _apiKey = '';
  final _language = 'ko-KR';

  @override
  Future<String> get({required String path, Map<String, String>? parameters}) async {
    if (_apiKey.isEmpty) {
      throw Exception('apiKey를 발급받아주세요.');
    }

    parameters?['language'] = _language;
    parameters?['api_key'] = _apiKey;

    var uri = Uri.https(_host, '/$_apiVersion/$path', parameters);
    var response = await http.get(uri);

    return response.body;
  }
}
