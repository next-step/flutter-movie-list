part of '../home.dart';

class MovieDetailWidgetArgument {
  Movie movie;

  MovieDetailWidgetArgument({required this.movie});
}

class MovieDetailWidget extends StatefulWidget {
  static const routeName = '/movieDetail';

  final Movie movie;

  const MovieDetailWidget({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetailWidget> createState() =>
      _MovieDetailWidgetState(movie: movie);
}

class _MovieDetailWidgetState extends State<MovieDetailWidget> {
  final Movie movie;

  _MovieDetailWidgetState({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(movie.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
