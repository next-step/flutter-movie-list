part of 'home.dart';

class _SearchView extends StatefulWidget {
  const _SearchView({Key? key}) : super(key: key);

  @override
  State<_SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<_SearchView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(repository: context.read()),
      child: GestureDetector(
        onTapUp: (details) => FocusScope.of(context).unfocus(),
        child: SafeArea(
          top: true,
          child: Stack(
            children: [
              _SearchBar(),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: _ResultView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      autofocus: true,
      textInputAction: TextInputAction.search,
      style: TextStyle(color: Colors.white),
      onEditingComplete: () {
        context.read<SearchBloc>().add(InputCompleteEvent(query: _textEditingController.text));
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.withOpacity(0.4),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintText: '검색',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        suffix: GestureDetector(
          onTap: _textEditingController.clear,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.clear,
              color: Colors.grey,
              size: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, DataLoadingState>(builder: (context, state) {
      if (state is LoadingState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is LoadedState<MovieList>) {
        final movies = state.data.results;

        return ListView.separated(
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                movies[index].title,
                style: TextStyle(color: Colors.white),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 5,
            );
          },
        );
      } else if (state is EmptyState) {
        return Center(
          child: Text(
            '검색 결과가 없습니다.',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        );
      }

      return SizedBox.shrink();
    });
  }
}
