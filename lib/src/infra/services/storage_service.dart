import 'package:news_test/src/data/models/news_list_response.dart';
import 'package:news_test/src/data/models/user_data_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static const String _userData = "UserData";
  static const String _bookmarks = "Bookmarks";

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserData(UserData userData) async {
    await _prefs.setString(_userData, userData.toRawJson());
  }

  Future<UserData> getUserData() async {
    return UserData.fromRawJson(_prefs.getString(_userData)!);
  }

  Future<void> saveBookmarkedNews(NewsListResponse news) async {
    await _prefs.setString(_bookmarks, news.toRawJson());
  }

  Future<NewsListResponse?> getBookmarkedNews() async {
    var res = _prefs.getString(_bookmarks);
    if(res != null){
      return NewsListResponse.fromRawJson(res);
    }else{
      return null;
    }

  }
}
