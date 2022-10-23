import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/bloc/movie_detail_bloc.dart';
import 'package:flutter_movie_list/repository/repository.dart';
import 'package:flutter_movie_list/repository/src/movie_detail_repository.dart';
import 'package:flutter_movie_list/screen/home.dart';
import 'package:flutter_movie_list/screen/widget/movie_detail.dart';

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
        onGenerateRoute: (settings) {
          if (settings.name == MovieDetailWidget.routeName) {
            final MovieDetailWidgetArgument args =
                settings.arguments as MovieDetailWidgetArgument;

            return MaterialPageRoute(
              builder: (context) {
                return BlocProvider(
                    create: (BuildContext context) => MovieDetailCubit(
                        repository: MovieDetailRepository(
                            apiProvider: ApiProviderImpl())),
                    child: MovieDetailWidget(
                      movie: args.movie,
                    ));
              },
            );
          }
        },
        home: MyHomePage(),
      ),
    );
  }
}
