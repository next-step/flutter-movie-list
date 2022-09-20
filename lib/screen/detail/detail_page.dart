import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/screen/detail/detail_bloc.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required int id})
      : _id = id,
        super(key: key);

  final int _id;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    context.read<DetailBloc>().add(FetchMovieDetail(id: widget._id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailBloc, DetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            elevation: 0,
            backgroundColor: Colors.black,
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(DetailState state) {
    if (state is Loading) {
      return _buildLoading(context);
    }

    if (state is Loaded) {
      return _buildLoaded(state);
    }

    return _buildError(context);
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLoaded(Loaded state) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: Colors.black,
          child: Image.network(
            'https://image.tmdb.org/t/p/original/${state.detail.backdropPath}',
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null);
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              state.detail.title,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Row(
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.red, size: 18.0),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    '${state.detail.voteAverage}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                state.detail.releaseDate,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              state.detail.overview,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return const Center(
      child: Image(
        image: NetworkImage('https://i0.wp.com/learn.onemonth.com/wp-content/uploads/2017/08/1-10.png?w=845&ssl=1'),
      ),
    );
  }
}
