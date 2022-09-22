import 'package:flutter/material.dart';
import 'package:flutter_movie_list/exception/unknown_routing_exception.dart';
import 'package:flutter_movie_list/screen/detail/detail_screen.dart';
import 'package:flutter_movie_list/screen/tab/tab_screen.dart';

const String tabRoute = '/';
const String detailRoute = '/detail';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case tabRoute:
      return MaterialPageRoute(builder: (context) => const TabScreen());
    case detailRoute:
      final id = settings.arguments as int;
      return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
    default:
      throw UnknownRoutingException();
  }
}