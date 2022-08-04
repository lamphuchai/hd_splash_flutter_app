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
    final textTheme = Theme.of(context).textTheme;
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 30, bottom: 30),
                  child: Wrap(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          title,
                          style: textTheme.headlineLarge,
                        ),
                      ),
                      const SizedBox(
                        width: double.infinity,
                        height: 10,
                      ),
                      if (subtitle != null) ...[
                        Text(
                          subtitle!,
                          style: textTheme.labelMedium,
                        )
                      ],
                      if (child != null) ...[child!]
                    ],
                  ),
                ),
              ),
            ],
        body: body);
  }
}
