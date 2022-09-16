import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/screen/home_bloc.dart';

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
            return _CoverCarouselWidget(movies: state.nowPlaying);
          case Section.popular:
            return _PosterCarouselWidget(type: PosterType.popular, movies: state.popular);
          case Section.upcoming:
            return _PosterCarouselWidget(type: PosterType.upcoming, movies: state.upcoming);
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
