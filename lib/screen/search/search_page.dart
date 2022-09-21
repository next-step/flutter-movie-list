import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie_list/screen/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final textFieldController = TextEditingController();

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    onChanged: _onSearchChanged,
                    controller: textFieldController,
                    cursorColor: Colors.grey,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.search, size: 22),
                        color: Colors.grey,
                        onPressed: () {
                          context.read<SearchBloc>().add(SearchMovies(query: textFieldController.text));
                          FocusScope.of(context).unfocus();
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel_rounded, size: 18),
                        color: Colors.grey.withOpacity(0.5),
                        onPressed: () => textFieldController.clear(),
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                    ),
                  ),
                ),
                _buildBody(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(SearchState state) {
    if (state is Empty) {
      return _buildEmpty(context);
    }

    if (state is Loading) {
      return _buildLoading(context);
    }

    if (state is Loaded) {
      return _buildLoaded(state);
    }

    return _buildError(context);
  }

  Widget _buildEmpty(BuildContext context) {
    return const SizedBox();
  }

  Widget _buildLoading(BuildContext context) {
    return const Expanded(child: Center(child: CircularProgressIndicator()));
  }

  Widget _buildLoaded(Loaded state) {
    return Expanded(
      child: ListView.builder(
        itemCount: state.searched.totalResults,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            child: Text(state.searched.results[index].title, style: const TextStyle(color: Colors.white, fontSize: 14)),
          );
        },
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return const Center(
      child: Image(
        image: NetworkImage('https://i0.wp.com/learn.onemonth.com/wp-content/uploads/2017/08/1-10.png?w=845&ssl=1'),
      ),
    );
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      debugPrint(textFieldController.text);
      context.read<SearchBloc>().add(SearchMovies(query: textFieldController.text));
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
