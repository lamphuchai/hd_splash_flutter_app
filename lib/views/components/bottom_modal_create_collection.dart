import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/views/components/components.dart';

class BottomModalCreateCollection extends StatefulWidget {
  const BottomModalCreateCollection({Key? key, required this.onSubmit})
      : super(key: key);
  final Function(Map<String, dynamic>) onSubmit;
  @override
  State<BottomModalCreateCollection> createState() =>
      _BottomModalCreateCollectionState();
}

class _BottomModalCreateCollectionState
    extends State<BottomModalCreateCollection> {
  String title = "";

  String? description;
  bool private = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              width: 50,
              height: 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.grey),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              "Create new collection",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 10,
          ),
          CustomTextField(
            labelText: "Title",
            helperText: "Required fields title",
            onChanged: (value) {
              setState(() => title = value);
            },
          ),
          CustomTextField(
            labelText: "Description",
            onChanged: (value) {
              setState(() => description = value);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      private = true;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: private ? Colors.green : null,
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 8),
                      child: const Text(("Private"))),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      private = false;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: private ? null : Colors.green,
                          border: Border.all(
                            color: Colors.black54,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 8, bottom: 8),
                      child: const Text(("Public"))),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (title == "") {
                        Navigator.pop(context);
                      } else {
                        widget.onSubmit({
                          "title": title,
                          "description": description,
                          "private": private
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        "Create",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    )),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text(
                        "Cannel",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
