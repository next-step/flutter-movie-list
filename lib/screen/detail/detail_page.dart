import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              color: Colors.amber,
            ),
          ),
          Container(
            color: Colors.orange,
            height: 60
          ),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                color: Colors.teal,
              ),
              Container(
                width: 100,
                height: 50,
                color: Colors.deepPurple,
              ),
              Expanded(
                child: Container(
                  height: 50,
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
