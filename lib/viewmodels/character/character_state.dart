import 'package:equatable/equatable.dart';
import '../../models/character_model.dart';

enum CharacterStatus { initial, loading, success, loadingMore, empty, error }

class CharacterState extends Equatable {
  final CharacterStatus status;
  final List<CharacterModel> characters;
  final String message;
  final int currentPage;
  final bool hasNext;

  const CharacterState({
    this.status = CharacterStatus.initial,
    this.characters = const [],
    this.message = '',
    this.currentPage = 1,
    this.hasNext = true,
  });

  CharacterState copyWith({
    CharacterStatus? status,
    List<CharacterModel>? characters,
    String? message,
    int? currentPage,
    bool? hasNext,
  }) {
    return CharacterState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      hasNext: hasNext ?? this.hasNext,
    );
  }

  @override
  List<Object?> get props => [
        status,
        characters,
        message,
        currentPage,
        hasNext,
      ];
}
