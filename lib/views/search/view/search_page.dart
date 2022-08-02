import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 20),
          child: Wrap(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Tìm kiếm",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 10,
              ),
              Text(
                "Hình ảnh,bộ sưa tập,chủ đề,người dùng ..",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                width: double.infinity,
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ],
          ),
        ),
        const ListTile(
          title: Text("Lịch sử"),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: Wrap(children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Chip(
                      label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("viet nam"),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Chip(
                      label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("viet nam"),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Chip(
                      label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("viet nam"),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: Chip(
                      label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Text("viet nam"),
                  )),
                )
              ])),
        ))
      ],
    );
  }
}
