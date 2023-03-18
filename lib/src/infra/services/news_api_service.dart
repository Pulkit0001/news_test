import 'package:dio/dio.dart';
import 'package:news_test/src/data/models/news_list_response.dart';

class ApiService {
  static const String baseUrl = "https://newsapi.org/v2/";
  static const String apiKey = "ffaab2ace29b41a5ae1e03233d96c6ec";
  static const String headlinesEndpoint = "top-headlines";

  Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<NewsListResponse> getNewsList({int page = 1, int limit = 20}) async {
    try {
      var res =
          await dio.get(headlinesEndpoint, queryParameters: {'apiKey': apiKey, 'language': 'en', 'page': page, 'pageSize': limit,});
      if(res.statusCode == 200 || res.statusCode == 201){
        return NewsListResponse.fromJson(res.data);
      }else{
        throw Exception("Api Error");
      }
    } catch (e) {
      rethrow;
    }
  }
}
