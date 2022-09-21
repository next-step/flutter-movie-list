import 'package:flutter/material.dart';
import 'package:flutter_movie_list/screen/tab/tab_page.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return const TabPage();
  }
}
