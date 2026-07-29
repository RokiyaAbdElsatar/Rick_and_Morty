import '../core/constants/api_constants.dart';
import '../core/network/api_client.dart';
import '../models/character_model.dart';

class CharacterService {
  final ApiClient _apiClient;

  CharacterService(this._apiClient);

  Future<({List<CharacterModel> characters, bool hasNext})> getCharacters({
    int page = 1,
    String? name,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
    };

    if (name != null && name.isNotEmpty) {
      queryParams['name'] = name;
    }

    final response = await _apiClient.dio.get(
      ApiConstants.characterEndpoint,
      queryParameters: queryParams,
    );

    final data = response.data as Map<String, dynamic>;
    final results = (data['results'] as List<dynamic>)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final info = data['info'] as Map<String, dynamic>;
    final next = info['next'] as String?;
    final hasNext = next != null;

    return (characters: results, hasNext: hasNext);
  }
}
