import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/bloc/movies_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'widget/cover_carousel.dart';
part 'widget/poster_carousel.dart';

enum Section {
  nowPlaying,
  popular,
  upcoming,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<MoviesBloc>(
                create: (BuildContext context) => MoviesBloc(
                    movieRepository:
                        MovieRepository(apiProvider: ApiProviderImpl()))),
            BlocProvider<MoviesBloc>(
                create: (BuildContext context) => MoviesBloc(
                    movieRepository:
                        MovieRepository(apiProvider: ApiProviderImpl()))),
          ],
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              switch (Section.values[index]) {
                case Section.nowPlaying:
                  return _CoverCarouselWidget();
                case Section.popular:
                  return _PosterCarouselWidget(
                    type: PosterType.popular,
                  );
                case Section.upcoming:
                  return _PosterCarouselWidget(
                    type: PosterType.upcoming,
                  );
                default:
                  throw UnimplementedError();
              }
            },
            itemCount: Section.values.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite_outline,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
