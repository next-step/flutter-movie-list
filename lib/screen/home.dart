import 'package:flutter/material.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/bloc/data_loading.dart';
import 'package:flutter_movie_list/bloc/main_bloc.dart';
import 'package:flutter_movie_list/bloc/search_bloc.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/screen/screen_arguments.dart';

part 'widget/cover_carousel.dart';
part 'widget/poster_carousel.dart';

part 'search.dart';

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
  int _currentIndex = 0;

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
    List<Widget> tabViews = [
      DataLoadingBuilder<MainCubit, DataLoadingState>(
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
      Center(
        child: Text(
          'Interest',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      _SearchView(),
      Center(
        child: Text(
          'My',
          style: TextStyle(color: Colors.orange),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: tabViews.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        backgroundColor: Colors.black,
        iconSize: 26,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}