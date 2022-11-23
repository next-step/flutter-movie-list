part of '../../search_screen.dart';

class _SearchField extends StatelessWidget {
  const _SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    var searchBloc = context.read<MovieSearchBloc>();
    return TextField(
      controller: searchController,
      onChanged: (value) => searchBloc.add(MovieSearchEvent(value)),
      onSubmitted: (value) => searchBloc.add(MovieSearchEvent(value)),
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
    );
  }
}
