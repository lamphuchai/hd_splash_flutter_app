import 'package:unsplash_dart/src/api/api.dart';
import 'package:unsplash_dart/src/network/dio_client.dart';

class Unsplash {
  late final Photos _photos;
  late final Collections _collections;
  late final Users _users;
  late final Search _search;
  late final Topics _topics;
  late final Stats _stats;

  void createApi(String clientId) {
    final dioClient = DioClient(clientId);
    _users = Users(dioClient);
    _photos = Photos(dioClient);
    _collections = Collections(dioClient);
    _search = Search(dioClient);
    _topics = Topics(dioClient);
    _stats = Stats(dioClient);
  }

  Photos get photos => _photos;
  Collections get collections => _collections;
  Users get users => _users;
  Search get search => _search;
  Topics get topics => _topics;
  Stats get stats => _stats;
}
