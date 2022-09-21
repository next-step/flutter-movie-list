import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: 25),
            TextField(
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search, size: 22),
                  color: Colors.grey,
                  onPressed: () {},
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel_rounded, size: 18),
                  color: Colors.grey.withOpacity(0.5),
                  onPressed: () {},
                ),
                hintText: '검색',
                hintStyle: const TextStyle(fontSize: 14, color: Colors.white),
                filled: true,
                fillColor: Colors.grey.withOpacity(0.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: Text('테스트 $index', style: const TextStyle(color: Colors.white, fontSize: 14)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
