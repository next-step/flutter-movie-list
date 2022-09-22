import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/router/router.dart';
import 'package:flutter_movie_list/screen/home/home_bloc.dart';

part 'widget/cover_carousel.dart';

part 'widget/poster_carousel.dart';

enum Section {
  nowPlaying,
  popular,
  upcoming,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<HomeBloc>().add(FetchMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, HomeState state) {
    if (state is Loading) {
      return _buildLoading(context);
    }

    if (state is Loaded) {
      return _buildLoaded(context, state);
    }

    return _buildError(context);
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoaded(BuildContext context, Loaded state) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        switch (Section.values[index]) {
          case Section.nowPlaying:
            return _CoverCarouselWidget(movies: state.nowPlaying, onTap: moveDetailById);
          case Section.popular:
            return _PosterCarouselWidget(type: PosterType.popular, movies: state.popular, onTap: moveDetailById);
          case Section.upcoming:
            return _PosterCarouselWidget(type: PosterType.upcoming, movies: state.upcoming, onTap: moveDetailById);
          default:
            throw UnimplementedError();
        }
      },
      itemCount: Section.values.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }

  void moveDetailById(int id) {
    Navigator.pushNamed(context, detailRoute, arguments: id);
  }

  Widget _buildError(BuildContext context) {
    return const Center(
      child: Image(
        image: NetworkImage(
          'https://i0.wp.com/learn.onemonth.com/wp-content/uploads/2017/08/1-10.png?w=845&ssl=1'
        ),
      ),
    );
  }
}
