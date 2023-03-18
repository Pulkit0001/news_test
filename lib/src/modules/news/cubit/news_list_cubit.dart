import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/src/data/models/news_list_response.dart';
import 'package:news_test/src/infra/services/storage_service.dart';
import 'package:news_test/src/modules/news/cubit/news_detail_state.dart';
import 'package:news_test/src/modules/news/cubit/news_list_state.dart';
import 'package:news_test/src/utils/enums.dart';
import 'package:news_test/src/utils/utility_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../infra/services/news_api_service.dart';

class NewsListCubit extends Cubit<NewsListState> {
  NewsListCubit(this.service,
      {required this.bookmarked, required this.apiService})
      : super(NewsListState.initial()) {
    refreshController = RefreshController();
    loadNewsList();
  }
  late RefreshController refreshController;
  final bool bookmarked;
  final ApiService apiService;
  final StorageService service;
  int page = 1;

  void loadNewsList() async {
    try {
      emit(state.copyWith(viewState: ViewState.loading));
      if (bookmarked) {
        var res = await service.getBookmarkedNews();
        if (res != null) {
          emit(state.copyWith(viewState: ViewState.idle, news: res.articles));
        } else {
          emit(state.copyWith(viewState: ViewState.empty, news: []));
        }
      } else {
        page = 1;
        var res = await apiService.getNewsList(
          page: page,
        );
        emit(state.copyWith(
            viewState: res.articles.isEmpty ? ViewState.empty : ViewState.idle,
            news: res.articles));
      }
      refreshController.loadComplete();
    } catch (e, str) {
      print(str);
      emit(state.copyWith(viewState: ViewState.error, message: e.toString()));
      refreshController.loadNoData();
    }
  }

  void loadNextPage() async {
    try {
      if (bookmarked) {
        var res = await service.getBookmarkedNews();
        if (res != null) {
          emit(state.copyWith(viewState: ViewState.idle, news: res.articles));
        } else {
          emit(state.copyWith(viewState: ViewState.empty, news: []));
        }
      } else {
        page++;
        var res = await apiService.getNewsList(
          page: page,
        );
        emit(state.copyWith(
            viewState: res.articles.isEmpty ? ViewState.empty : ViewState.idle,
            news: <News>[...state.news, ...res.articles]));
      }
      refreshController.loadComplete();
    } catch (e, str) {
      print(str);
      // emit(state.copyWith(viewState: ViewState.error, message: e.toString()));
      refreshController.loadNoData();
    }
  }

  addInBookMark(News news) async {
    try {
      var res = await service.getBookmarkedNews();
      if (res != null &&
          !res.articles.map((e) => e.publishedAt).contains(news.publishedAt)) {
        List<News> newList = res.articles;
        newList.add(news);
        var newRes = NewsListResponse(
            status: res.status,
            totalResults: res.totalResults + 1,
            articles: newList);
        service.saveBookmarkedNews(newRes);

      } else if(res == null){
        List<News> newList = <News>[];
        newList.add(news);
        var newRes =
            NewsListResponse(status: "", totalResults: 1, articles: newList);
        service.saveBookmarkedNews(newRes);
      }
    } catch (e) {}
  }
}
