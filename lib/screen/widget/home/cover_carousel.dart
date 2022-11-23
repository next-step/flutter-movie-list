part of '../../home_screen.dart';

class _CoverCarouselWidget extends StatelessWidget {
  const _CoverCarouselWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MovieListBloc>().add(LoadMoviesEvent(Section.nowPlaying));
    return BlocProvider<_IndexCubit>(
      create: (context) => _IndexCubit(),
      child: SizedBox(
        height: 340,
        child: Stack(
          children: [
            BlocBuilder<MovieListBloc, MovieListState>(
              buildWhen: _whenMovieListLoaded,
              builder: (context, state) {
                if (state is MovieListLoadedState) {
                  return PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        return _CarouselTile(
                          movie: state.movies[index],
                        );
                      },
                      onPageChanged: (index) {
                        BlocProvider.of<_IndexCubit>(context)
                            .changeIndex(index);
                      });
                }
                return const SizedBox();
              },
            ),
            Positioned(
              left: 20,
              bottom: 5,
              child: BlocBuilder<MovieListBloc, MovieListState>(
                buildWhen: _whenMovieListLoaded,
                builder: (context, state) {
                  return _CarouselIndicator(
                    totalCount:
                        state is MovieListLoadedState ? state.length : 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _whenMovieListLoaded(MovieListState before, MovieListState after) {
    return after is MovieListLoadedState && after.section == Section.nowPlaying;
  }
}

class _CarouselIndicator extends StatefulWidget {
  const _CarouselIndicator({
    required this.totalCount,
    Key? key,
  }) : super(key: key);

  final int totalCount;

  @override
  State<_CarouselIndicator> createState() => _CarouselIndicatorState();
}

class _CarouselIndicatorState extends State<_CarouselIndicator> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3,
      children: List.generate(
        widget.totalCount,
        (index) => BlocBuilder<_IndexCubit, int>(
          builder: (context, indexState) => Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: index == indexState
                  ? Colors.white.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class _CarouselTile extends StatelessWidget {
  const _CarouselTile({
    required this.movie,
    Key? key,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(id: movie.id),
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://image.tmdb.org/t/p/original/${movie.backdropPath}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IndexCubit extends Cubit<int> {
  _IndexCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
