part of '../../home_screen.dart';

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

  Section get section {
    switch (this) {
      case PosterType.popular:
        return Section.popular;
      case PosterType.upcoming:
        return Section.upcoming;
    }
  }
}

class _PosterCarouselWidget extends StatelessWidget {
  final PosterType type;

  const _PosterCarouselWidget({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<MovieListBloc>().add(LoadMoviesEvent(type.section));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            type.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 300,
          ),
          child: BlocBuilder<MovieListBloc, MovieListState>(
            buildWhen: (before, after) =>
                after is MovieListLoadedState && after.section == type.section,
            builder: (context, state) {
              if (state is MovieListLoadedState) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: _PosterTile(
                          movie: state.movies[index],
                        ),
                      );
                    }

                    return _PosterTile(
                      movie: state.movies[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                );
              }
              return const SizedBox();
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
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(id: movie.id),
        ),
      ),
      child: SizedBox(
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
            const SizedBox(
              height: 10,
            ),
            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
