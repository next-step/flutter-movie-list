part of '../home.dart';

class _CoverCarouselWidget extends StatefulWidget {
  const _CoverCarouselWidget({Key? key}) : super(key: key);

  @override
  State<_CoverCarouselWidget> createState() => _CoverCarouselWidgetState();
}

class _CoverCarouselWidgetState extends State<_CoverCarouselWidget> {
  late final MovieListBloc _movieListBloc;

  @override
  void initState() {
    super.initState();

    _movieListBloc = MovieListBloc(
      repository: MovieRepository(
        apiProvider: ApiProviderImpl(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _movieListBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieListBloc,
      child: SizedBox(
        height: 340,
        child: Stack(
          children: [
            BlocConsumer<MovieListBloc, MovieListState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.movies.length,
                    itemBuilder: (context, index) {
                      return _CarouselTile(
                        movie: state.movies[index],
                      );
                    },
                    onPageChanged: (index) =>
                        _movieListBloc.add(ChangeIndexEvent(index)),
                  );
                }),
            Positioned(
              left: 20,
              bottom: 5,
              child: BlocConsumer<MovieListBloc, MovieListState>(
                listener: (context, state) {},
                builder: (context, state) => _CarouselIndicator(
                  totalCount: state.movies.length,
                  currentIndex: state.currentIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarouselIndicator extends StatefulWidget {
  const _CarouselIndicator({
    required this.totalCount,
    required this.currentIndex,
    Key? key,
  }) : super(key: key);

  final int totalCount;
  final int currentIndex;

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
        (index) => Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: index == widget.currentIndex
                ? Colors.white.withOpacity(0.8)
                : Colors.grey.withOpacity(0.2),
            shape: BoxShape.circle,
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
    return Container(
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
    );
  }
}
