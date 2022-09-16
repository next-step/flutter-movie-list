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
    final stateType = state.runtimeType;
    switch (stateType) {
      case Loading:
        return _buildLoading(context);
      case Loaded:
        return _buildLoaded(context);
      default:
        return const SizedBox();
    }
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoaded(BuildContext context) {
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
  }
}
