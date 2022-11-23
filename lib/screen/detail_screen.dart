import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/movie_detail_bloc.dart';

import '../repository/src/movie_repository.dart';

part 'widget/detail/detail_title.dart';
part 'widget/detail/detail_overview.dart';
part 'widget/detail/detail_start_and_release_date.dart';

class DetailScreen extends StatelessWidget {
  final int id;

  const DetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return MovieDetailBloc(
            repository: context.read<MovieRepository>(),
        )..add(MovieDetailEvent(id));
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _DetailImage(),
              SizedBox(
                height: 40,
              ),
              _DetailTitle(),
              SizedBox(
                height: 20,
              ),
              _DetailStartAndReleaseDate(),
              SizedBox(
                height: 5,
              ),
              _DetailOverview(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailImage extends StatelessWidget {
  const _DetailImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state.detail?.backdropPath != null) {
          return Image.network(
            'https://image.tmdb.org/t/p/original${state.detail?.backdropPath ?? ''}',
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 100,
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
