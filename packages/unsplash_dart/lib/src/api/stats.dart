import '../network/dio_client.dart';


abstract class StatsAbs {
  Future<Map<String, dynamic>> getTotals();
  Future<Map<String, dynamic>> getMonth();
}

class Stats extends StatsAbs {
  Stats(this._dioClient);
  final DioClient _dioClient;
  @override
  Future<Map<String, dynamic>> getTotals() async {
    final data = await _dioClient.get('/stats/total');
    return data;
  }

  @override
  Future<Map<String, dynamic>> getMonth() async {
    final data = await _dioClient.get('/stats/month');
    return data;
  }
}
