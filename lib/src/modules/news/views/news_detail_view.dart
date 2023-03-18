import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_test/src/app/views/app.dart';
import 'package:news_test/src/modules/news/cubit/news_detail_cubit.dart';
import 'package:news_test/src/modules/news/cubit/news_detail_state.dart';

import '../../../data/models/news_list_response.dart';

class NewsDetailView extends StatelessWidget {
  const NewsDetailView({Key? key}) : super(key: key);

  static Route<dynamic> getRoute({required News news}) => MaterialPageRoute(
        builder: (context) => BlocProvider<NewsDetailCubit>(
          create: (_) => NewsDetailCubit(news: news),
          child: const NewsDetailView(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsDetailCubit, NewsDetailState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () {
              navigatorKey.currentState?.pop();
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            children: [
              Text(state.news.title, style: Theme.of(context).textTheme.headline6,),
              SizedBox(height: 12,),
              Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(state.news.urlToImage, fit: BoxFit.fill,)),
              SizedBox(height: 12,),

              Row(
                children: [
                  Text(DateFormat('MMM dd, yyyy HH:mm ')
                      .format(state.news.publishedAt)),
                  const Spacer(),
                  Text("Source: ${state.news.source.name}"),
                ],
              ),
              SizedBox(height: 12,),

              Text("Description: ${state.news.description}"),
              SizedBox(height: 12,),

              Text("Full Article: ${state.news.content}"),
            ],
          ),
        ),
      );
    });
  }
}
