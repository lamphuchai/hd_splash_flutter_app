import 'package:flutter/material.dart';

class CustomNestedScrollHead extends StatelessWidget {
  const CustomNestedScrollHead(
      {Key? key,
      required this.body,
      required this.title,
      this.subtitle,
      this.child})
      : super(key: key);
  final Widget body;
  final String title;
  final String? subtitle;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 30, bottom: 30),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        const SizedBox(
                          width: double.infinity,
                          height: 10,
                        ),
                        if (subtitle != null) ...[
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        ],
                        if (child != null) ...[child!]
                      ],
                    ),
                  )
                ]),
              )
            ],
        body: body);
  }
}
