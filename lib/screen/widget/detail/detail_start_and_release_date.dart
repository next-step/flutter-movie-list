part of '../../detail_screen.dart';

class _DetailStartAndReleaseDate extends StatelessWidget {
  const _DetailStartAndReleaseDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          '★',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) => Text(
            '${state.detail?.voteAverage ?? 0.0} ${state.detail?.releaseDate ?? ''}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}