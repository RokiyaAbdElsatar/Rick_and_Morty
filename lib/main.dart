import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/network/api_client.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'repositories/character_repository.dart';
import 'services/character_service.dart';
import 'viewmodels/character/character_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final apiClient = ApiClient();
  final characterService = CharacterService(apiClient);
  final characterRepository = CharacterRepository(characterService);

  runApp(
    RickAndMortyApp(characterRepository: characterRepository),
  );
}

class RickAndMortyApp extends StatelessWidget {
  final CharacterRepository characterRepository;

  const RickAndMortyApp({
    super.key,
    required this.characterRepository,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => CharacterCubit(characterRepository),
          child: MaterialApp.router(
            title: 'Rick & Morty Explorer',
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
