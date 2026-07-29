import '../models/character_model.dart';
import '../services/character_service.dart';

class CharacterRepository {
  final CharacterService _characterService;

  CharacterRepository(this._characterService);

  Future<({List<CharacterModel> characters, bool hasNext})> getCharacters({
    int page = 1,
    String? name,
  }) async {
    return _characterService.getCharacters(page: page, name: name);
  }
}
