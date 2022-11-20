import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      // 가로축 가운데 정렬
      child: Column(
        // 세로 컬럼 생성
        mainAxisAlignment: MainAxisAlignment.center, // 새로축 가운데 정렬
        children: const [
          Text(
            'detail page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
