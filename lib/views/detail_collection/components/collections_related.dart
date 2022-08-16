import 'package:flutter/material.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/router/route_name.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:unsplash_dart/unsplash_dart.dart';

class CollectionsRelated extends StatelessWidget {
  const CollectionsRelated({Key? key, required this.relatedCollection})
      : super(key: key);
  final List<Collection> relatedCollection;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Wrap(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 15,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.center,
            child: Text(
              context.lang("related-collections"),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
          SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                  itemCount: relatedCollection.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) => Padding(
                        padding: EdgeInsets.only(
                            left: 10,
                            right:
                                relatedCollection.length == index + 1 ? 10 : 0),
                        child: ItemCollection(
                            collection: relatedCollection[index]),
                      )))),
          const SizedBox(
            width: double.infinity,
            height: 20,
          ),
        ],
      ),
    );
  }
}

class ItemCollection extends StatelessWidget {
  const ItemCollection({Key? key, required this.collection}) : super(key: key);
  final Collection collection;
  @override
  Widget build(BuildContext context) {
    String uri = "";
    if (collection.coverPhoto != null) {
      uri = collection.coverPhoto!.urls.regular;
    } else if (collection.previewPhotos.isNotEmpty) {
      uri = collection.previewPhotos[0].urls.regular;
    } else {
      uri = collection.user.profileImage.large;
    }
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, RouteName.detailCollection,
            arguments: collection),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: context.screenSize.width * 1 / 2,
              height: 200,
              child: Stack(children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: collection.coverPhoto?.color.converterColor,
                    child: CustomCacheNetworkImage(
                      imageUrl: uri,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(
                              collection.title,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${collection.totalPhotos} ${context.lang("photos")}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 11),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          collection.user.name,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                )
              ]),
            )));
  }
}
