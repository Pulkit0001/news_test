import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/src/modules/news/cubit/news_detail_state.dart';

import '../../../data/models/news_list_response.dart';

class NewsDetailCubit extends Cubit<NewsDetailState> {
  NewsDetailCubit({required this.news})
      : super(NewsDetailState.initial(news: news));

  final News news;
}
