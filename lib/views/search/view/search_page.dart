import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const TextField(
      //     decoration: InputDecoration(
      //         fillColor: Colors.grey, filled: true, border: InputBorder.none),
      //   ),
      // ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child:
                  Align(alignment: Alignment.centerLeft, child: Text("Search")),
            ),
          ),
          const ListTile(
            title: Text("Lịch sử"),
          ),
          const Expanded(
              child: Center(
            child: Text("Bạn chưa tìm gì !!"),
          ))
        ],
      ),
    );
  }
}
