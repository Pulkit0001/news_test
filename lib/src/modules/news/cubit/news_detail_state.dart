import 'package:news_test/src/utils/enums.dart';

import '../../../data/models/news_list_response.dart';

class NewsDetailState {
  final News news;
  final ViewState viewState;
  final String? message;

  NewsDetailState({required this.news, required this.viewState, this.message});

  factory NewsDetailState.initial({required News news}) =>
      NewsDetailState(news: news, viewState: ViewState.empty);

  NewsDetailState copyWith(
          {News? news, ViewState? viewState, String? message}) =>
      NewsDetailState(
        news: news ?? this.news,
        viewState: viewState ?? this.viewState,
        message: message ?? this.message,
      );
}
