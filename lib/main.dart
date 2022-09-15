import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/screen/home.dart';
import 'package:flutter_movie_list/screen/movie_detail.dart';
import 'package:flutter_movie_list/screen/screen_arguments.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return RepositoryProvider<MovieRepository>(
      create: (context) => MovieRepository(apiProvider: ApiProviderImpl()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePageWrapper(),
        onGenerateRoute: (settings) {
          Widget? screen;
          if (settings.name == '/movie/detail') {
            final ScreenArguments? args = settings.arguments as ScreenArguments?;
            if (args?.movieId != null) {
              screen = MovieDetailScreen(movieId: args!.movieId!);
            }
          }

          if (screen == null) throw UnimplementedError('존재하지 않는 path 입니다.');

          return MaterialPageRoute(builder: (context) => screen!);
        },
      ),
    );
  }
}