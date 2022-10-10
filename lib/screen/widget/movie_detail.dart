part of '../home.dart';

class _MovieDetail extends StatefulWidget {
  const _MovieDetail({Key? key}) : super(key: key);

  @override
  State<_MovieDetail> createState() => _MovieDetailWidgetState();
}

class _MovieDetailWidgetState extends State<_MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Movie Detail'),
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
