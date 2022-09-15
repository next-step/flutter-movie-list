import 'package:flutter/material.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/bloc/data_loading.dart';
import 'package:flutter_movie_list/bloc/main_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'widget/cover_carousel.dart';
part 'widget/poster_carousel.dart';

enum Section {
  nowPlaying,
  popular,
  upcoming,
}

class MyHomePageWrapper extends StatelessWidget {
  const MyHomePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NowPlayingMovieCubit(
            repository: context.read(),
          )..load(),
        ),
        BlocProvider(
          create: (context) => PopularMovieCubit(
            repository: context.read(),
          )..load(),
        ),
        BlocProvider(
          create: (context) => UpcomingMovieCubit(
            repository: context.read(),
          )..load(),
        ),
      ],
      child: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MainCubit _cubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cubit = MainCubit(
      cubits: [
        context.read<NowPlayingMovieCubit>(),
        context.read<PopularMovieCubit>(),
        context.read<UpcomingMovieCubit>(),
        // Provider.of<NowPlayingMovieCubit>(context, listen: false),
        // Provider.of<PopularMovieCubit>(context, listen: false),
        // Provider.of<UpcomingMovieCubit>(context, listen: false),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DataLoadingBuilder<MainCubit, DataLoadingState>(
        bloc: _cubit,
        builder: (context, state) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
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
          );
        },
        onError: (context) {
          return Center(
            child: TextButton(
              onPressed: () {
                _cubit.refresh();
              },
              child: Text(
                'Error',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        onLoad: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
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