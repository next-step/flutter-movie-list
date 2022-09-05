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
  final MovieRepository _repository = MovieRepository(apiProvider: ApiProviderImpl());
  List<Movie> _movies = [];

  @override
  void initState() {
    super.initState();

    _loadMovies();
  }

  void _loadMovies() async {
    late List<Movie> movies;

    if (widget.type == PosterType.popular) {
      final result = await _repository.getPopular();
      movies = result.results;
    } else if (widget.type == PosterType.upcoming) {
      final result = await _repository.getUpcoming();
      movies = result.results;
    } else {
      //do nothing
      movies = [];
    }

    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: _movies.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: _PosterTile(
                    movie: _movies[index],
                  ),
                );
              }

              return _PosterTile(
                movie: _movies[index],
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