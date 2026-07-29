import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/routes.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/responsive_wrapper.dart';
import '../../viewmodels/character/character_cubit.dart';
import '../../viewmodels/character/character_state.dart';
import 'widgets/character_card.dart';
import 'widgets/empty_widget.dart';
import 'widgets/error_widget.dart';
import 'widgets/loading_widget.dart';
import 'widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<CharacterCubit>().fetchCharacters();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 400) {
      context.read<CharacterCubit>().loadNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rick & Morty')),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onChanged: (query) {
              setState(() {});
              context.read<CharacterCubit>().searchCharacters(query);
            },
            onClear: () {
              _searchController.clear();
              setState(() {});
              context.read<CharacterCubit>().fetchCharacters();
            },
          ),
          Expanded(
            child: BlocBuilder<CharacterCubit, CharacterState>(
              builder: (context, state) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: KeyedSubtree(
                    key: ValueKey(state.status),
                    child: _buildBody(state),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CharacterState state) {
    switch (state.status) {
      case CharacterStatus.initial:
      case CharacterStatus.loading:
        return const LoadingWidget();
      case CharacterStatus.error:
        return HomeErrorWidget(
          message: state.message,
          onRetry: () => context.read<CharacterCubit>().retry(),
        );
      case CharacterStatus.empty:
        return const EmptyWidget();
      case CharacterStatus.success:
      case CharacterStatus.loadingMore:
        return LayoutBuilder(
          builder: (context, constraints) {
            final columns = gridColumnCount(constraints.maxWidth);
            final aspectRatio = gridCardAspectRatio(constraints.maxWidth);
            final spacing = gridSpacing(context);
            return ResponsiveWrapper(
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification &&
                      _scrollController.position.pixels >=
                          _scrollController.position.maxScrollExtent - 400) {
                    context.read<CharacterCubit>().loadNextPage();
                  }
                  return false;
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(
                        16,
                        4,
                        16,
                        context.isDesktop ? 32 : 16,
                      ),
                      sliver: SliverGrid(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: spacing,
                          crossAxisSpacing: spacing,
                          childAspectRatio: aspectRatio,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => CharacterCard(
                            character: state.characters[index],
                            index: index,
                            onTap: () => context.push(
                              Routes.details,
                              extra: state.characters[index],
                            ),
                          ),
                          childCount: state.characters.length,
                        ),
                      ),
                    ),
                    if (state.status == CharacterStatus.loadingMore)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: context.isDesktop ? 40 : 24,
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
    }
  }
}
