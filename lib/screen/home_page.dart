import 'package:flutter/material.dart';
import 'package:flutter_movie_list/api/api_provider.dart';
import 'package:flutter_movie_list/model/model.dart';
import 'package:flutter_movie_list/repository/repository.dart';

part 'widget/cover_carousel.dart';
part 'widget/poster_carousel.dart';

enum Section {
  nowPlaying,
  popular,
  upcoming,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            switch (Section.values[index]) {
              case Section.nowPlaying:
                return _CoverCarouselWidget();
              case Section.popular:
                return _PosterCarouselWidget(
                  type: PosterType.popular,
                );
              case Section.upcoming:
                return _PosterCarouselWidget(
                  type: PosterType.upcoming,
                );
              default:
                throw UnimplementedError();
            }
          },
          itemCount: Section.values.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: IconTheme(
          data: IconThemeData(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite_outline,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.person_outline),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}