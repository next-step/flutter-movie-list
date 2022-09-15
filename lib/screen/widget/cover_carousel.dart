part of '../home.dart';

class _CoverCarouselWidget extends StatefulWidget {
  const _CoverCarouselWidget({Key? key}) : super(key: key);

  @override
  State<_CoverCarouselWidget> createState() => _CoverCarouselWidgetState();
}

class _CoverCarouselWidgetState extends State<_CoverCarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NowPlayingMovieCubit, DataLoadingState>(
      builder: (context, state) {
        if (state is LoadedState<MovieList>) {
          final movies = state.data.results;

          return SizedBox(
            height: 340,
            child: Stack(
              children: [
                PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    return _CarouselTile(
                      movie: movies[index],
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                Positioned(
                  left: 20,
                  bottom: 5,
                  child: _CarouselIndicator(
                    totalCount: movies.length,
                    currentIndex: _currentIndex,
                  ),
                ),
              ],
            ),
          );
        }

        return SizedBox.shrink();
      },
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
            color: index == widget.currentIndex ? Colors.white.withOpacity(0.8) : Colors.grey.withOpacity(0.2),
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
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        '/movie/detail',
        arguments: ScreenArguments(
          movieId: movie.id,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://image.tmdb.org/t/p/original/${movie.backdropPath}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: TextStyle(
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