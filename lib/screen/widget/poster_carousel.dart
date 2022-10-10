part of '../home.dart';

enum PosterType {
  popular,
  upcoming,
}

extension on PosterType {
  // String get name => describeEnum(this);

  String get name {
    switch (this) {
      case PosterType.popular:
        return 'Popular';
      case PosterType.upcoming:
        return 'Upcoming';
    }
  }
}

class _PosterCarouselWidget extends StatefulWidget {
  const _PosterCarouselWidget({
    required this.type,
    Key? key,
  }) : super(key: key);

  final PosterType type;

  @override
  State<_PosterCarouselWidget> createState() => _PosterCarouselWidgetState();
}

class _PosterCarouselWidgetState extends State<_PosterCarouselWidget> {
  @override
  void initState() {
    super.initState();

    _loadMovies();
  }

  void _loadMovies() {
    if (widget.type == PosterType.popular) {
      context.read<PopularMovieCubit>().load();
    } else if (widget.type == PosterType.upcoming) {
      context.read<UpcomingMovieCubit>().load();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == PosterType.popular) {
      return BlocBuilder<PopularMovieCubit, ApiState>(
          builder: (context, state) {
        if (state is LoadedState) {
          List<Movie> movies = state.data.results;

          return _buildCarousel(movies);
        }

        if (state is LoadErrorState) {
          return _buildError();
        }

        return _buildLoading();
      });
    } else if (widget.type == PosterType.upcoming) {
      return BlocBuilder<UpcomingMovieCubit, ApiState>(
          builder: (context, state) {
        if (state is LoadedState) {
          List<Movie> movies = state.data.results;

          return _buildCarousel(movies);
        }

        if (state is LoadErrorState) {
          return _buildError();
        }

        return _buildLoading();
      });
    } else {
      return _buildError();
    }
  }

  Widget _buildError() {
    return SizedBox.shrink();
  }

  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        width: 42,
        height: 42,
        child: CircularProgressIndicator(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildCarousel(List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            widget.type.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300,
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: _PosterTile(
                    movie: movies[index],
                  ),
                );
              }

              return _PosterTile(
                movie: movies[index],
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 20,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PosterTile extends StatelessWidget {
  const _PosterTile({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
              fit: BoxFit.fitHeight,
              height: 230,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            movie.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
