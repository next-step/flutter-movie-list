part of '../../search_screen.dart';

class _SearchResultList extends StatelessWidget {
  const _SearchResultList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieSearchBloc, MovieSearchState>(
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
            return const Text(
              'error',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.fade,
            );
          default:
            return Container();
        }
      },
    );
  }
}
