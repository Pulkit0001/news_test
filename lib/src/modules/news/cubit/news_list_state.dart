import 'package:news_test/src/utils/enums.dart';

import '../../../data/models/news_list_response.dart';

class NewsListState {
  final List<News> news;
  final ViewState viewState;
  final String? message;

  NewsListState({required this.news, required this.viewState, this.message});

  factory NewsListState.initial() =>
      NewsListState(news: [], viewState: ViewState.empty);

  NewsListState copyWith(
      {List<News>? news, ViewState? viewState, String? message}) =>
      NewsListState(
        news: news ?? this.news,
        viewState: viewState ?? this.viewState,
        message: message ?? this.message,
      );
}

