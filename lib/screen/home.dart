import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/bloc/movie_list_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'widget/cover_carousel.dart';

part 'widget/poster_carousel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MovieListBloc _movieListBloc = MovieListBloc(
    repository: MovieRepository(
      apiProvider: ApiProviderImpl(),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _movieListBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieListBloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: BlocBuilder<MovieListBloc, MovieListState>(
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
                      return _CoverCarouselWidget(
                        movieListBloc: _movieListBloc,
                      );
                    case Section.popular:
                      return _PosterCarouselWidget(
                        type: PosterType.popular,
                        movieListBloc: _movieListBloc,
                      );
                    case Section.upcoming:
                      return _PosterCarouselWidget(
                        type: PosterType.upcoming,
                        movieListBloc: _movieListBloc,
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
                  onPressed: () {},
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
}
