import '../network/dio_client.dart';


abstract class StatsAbs {
  Future<Map<String, dynamic>> totals();
  Future<Map<String, dynamic>> month();
}

class Stats extends StatsAbs {
  Stats(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<Map<String, dynamic>> month() async {
    final data = await _dioClient.get('/stats/total');
    return data;
  }

  @override
  Future<Map<String, dynamic>> totals() async {
    final data = await _dioClient.get('/stats/month');
    return data;
  }
}
