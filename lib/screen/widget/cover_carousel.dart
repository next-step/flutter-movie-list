part of '../home.dart';

class _CoverCarouselWidget extends StatefulWidget {
  const _CoverCarouselWidget({Key? key}) : super(key: key);

  @override
  State<_CoverCarouselWidget> createState() => _CoverCarouselWidgetState();
}

class _CoverCarouselWidgetState extends State<_CoverCarouselWidget> {
  late final MovieListBloc _movieListBloc;
  final _currentIndexCubit = _IndexCubit();

  @override
  void initState() {
    super.initState();

    _movieListBloc = MovieListBloc(
        repository: MovieRepository(
          apiProvider: ApiProviderImpl(),
        ),
        section: Section.nowPlaying);
  }

  @override
  void dispose() {
    super.dispose();
    _movieListBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _movieListBloc),
        BlocProvider(create: (context) => _currentIndexCubit)
      ],
      child: SizedBox(
        height: 340,
        child: Stack(
          children: [
            BlocBuilder<MovieListBloc, MovieListState>(
              builder: (context, state) {
                return PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return _CarouselTile(
                        movie: state.movies[index],
                      );
                    },
                    onPageChanged: (index) {
                      _currentIndexCubit.changeIndex(index);
                    });
              },
            ),
            Positioned(
              left: 20,
              bottom: 5,
              child: BlocBuilder<MovieListBloc, MovieListState>(
                builder: (context, state) => _CarouselIndicator(
                  totalCount: state.movies.length,
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
          builder: (context, state) => Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: index == state
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

class _IndexCubit extends Cubit<int> {
  _IndexCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
