import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/bloc/movie_search_bloc.dart';

import '../repository/src/movie_repository.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var searchBloc =
        MovieSearchBloc(repository: context.read<MovieRepository>());
    return BlocProvider<MovieSearchBloc>(
      create: (context) => searchBloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchBloc.add(MovieSearchEvent(value));
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    gapPadding: 0),
                filled: true,
                fillColor: const Color.fromRGBO(158, 158, 158, 0.4),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  onPressed: searchController.clear,
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                ),
              ),
              cursorColor: Colors.grey,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: BlocBuilder<MovieSearchBloc, MovieSearchState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case MovieSearchLoadingState:
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 100,
                  ),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              case MovieSearchLoadedState:
                state as MovieSearchLoadedState;
                var results = state.results?.results ?? const [];
                return ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print('selected movie!! ${results[index].title}');
                    },
                    child: SizedBox(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            fit: FlexFit.loose,
                            child: Text(
                              results[index].title,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              case MovieSearchErrorState:
                return Container();
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
