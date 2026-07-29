import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/character_repository.dart';
import 'character_state.dart';
import 'search_debounce.dart';

class CharacterCubit extends Cubit<CharacterState> {
  final CharacterRepository _repository;
  Timer? _debounceTimer;
  String _currentQuery = '';

  CharacterCubit(this._repository) : super(const CharacterState());

  Future<void> fetchCharacters({int page = 1, String? name}) async {
    if (page == 1) {
      emit(state.copyWith(
        status: CharacterStatus.loading,
        currentPage: page,
      ));
    } else {
      emit(state.copyWith(status: CharacterStatus.loadingMore));
    }

    try {
      final result = await _repository.getCharacters(
        page: page,
        name: name,
      );

      final characters = (page == 1)
          ? result.characters
          : [...state.characters, ...result.characters];

      if (characters.isEmpty) {
        emit(state.copyWith(
          status: CharacterStatus.empty,
          characters: characters,
          hasNext: false,
        ));
      } else {
        emit(state.copyWith(
          status: CharacterStatus.success,
          characters: characters,
          hasNext: result.hasNext,
          currentPage: page,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CharacterStatus.error,
        message: e.toString(),
      ));
    }
  }

  void searchCharacters(String query) {
    _currentQuery = query;
    _debounceTimer?.cancel();
    _debounceTimer = Timer(
      const Duration(milliseconds: SearchDebounce.debounceTime),
      () {
        fetchCharacters(page: 1, name: _currentQuery);
      },
    );
  }

  void loadNextPage() {
    if (state.hasNext && state.status != CharacterStatus.loadingMore) {
      fetchCharacters(
        page: state.currentPage + 1,
        name: _currentQuery.isNotEmpty ? _currentQuery : null,
      );
    }
  }

  void retry() {
    fetchCharacters(
      page: state.currentPage,
      name: _currentQuery.isNotEmpty ? _currentQuery : null,
    );
  }

  String get currentQuery => _currentQuery;

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
