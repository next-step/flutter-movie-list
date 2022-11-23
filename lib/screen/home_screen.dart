import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/movie_list_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/screen/detail_screen.dart';
import 'package:flutter_movie_list/screen/search_screen.dart';

part 'widget/home/cover_carousel.dart';
part 'widget/home/poster_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieListBloc(
        repository: context.read<MovieRepository>(),
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: BlocBuilder<MovieListBloc, MovieListState>(
            buildWhen: _isMovieListBlocChangeErrorState,
            builder: (context, state) {
              if (state is MovieListErrorState) {
                return Center(
                  // 가로축 가운데 정렬
                  child: Column(
                    // 세로 컬럼 생성
                    mainAxisAlignment: MainAxisAlignment.center, // 새로축 가운데 정렬
                    children: [
                      Text(
                        state.errMsg,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              }

              return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  switch (Section.values[index]) {
                    case Section.nowPlaying:
                      return const _CoverCarouselWidget();
                    case Section.popular:
                      return const _PosterCarouselWidget(
                        type: PosterType.popular,
                      );
                    case Section.upcoming:
                      return const _PosterCarouselWidget(
                        type: PosterType.upcoming,
                      );
                    default:
                      throw UnimplementedError();
                  }
                },
                itemCount: Section.values.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: IconTheme(
            data: const IconThemeData(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.favorite_outline,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.person_outline),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isMovieListBlocChangeErrorState(
      MovieListState before, MovieListState after) {
    return (before is MovieListErrorState && after is MovieListLoadedState) ||
        (before is MovieListLoadedState && after is MovieListErrorState);
  }
}
