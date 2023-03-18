import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:news_test/src/app/views/app.dart';
import 'package:news_test/src/infra/services/news_api_service.dart';
import 'package:news_test/src/infra/services/storage_service.dart';
import 'package:news_test/src/modules/news/cubit/news_list_cubit.dart';
import 'package:news_test/src/modules/news/cubit/news_list_state.dart';
import 'package:news_test/src/modules/news/views/news_detail_view.dart';
import 'package:news_test/src/utils/enums.dart';
import 'package:news_test/src/utils/utility_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsListView extends StatelessWidget {
  const NewsListView({Key? key}) : super(key: key);

  static Widget getWidget({bool bookmarked = false}) =>
      BlocProvider<NewsListCubit>(
        create: (_) => NewsListCubit(StorageService(),
            bookmarked: bookmarked, apiService: ApiService()),
        child: const NewsListView(),
      );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsListCubit, NewsListState>(
      builder: (context, state) {
        switch (state.viewState) {
          case ViewState.loading:
            {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          case ViewState.idle:
            return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: const WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = const Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = const CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Text("release to load more");
                    } else {
                      body = const Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: context.read<NewsListCubit>().refreshController,
                onRefresh: context.read<NewsListCubit>().loadNewsList,
                onLoading: context.read<NewsListCubit>().loadNextPage,
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      navigatorKey.currentState?.push(
                          NewsDetailView.getRoute(news: state.news[index]));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      height: MediaQuery.of(context).size.height * 0.175,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        // border: Border.all(color: Colors.black12,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(4, 4),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          state.news[index].urlToImage,
                                          errorBuilder: (a, b, c) => Icon(
                                            Icons.error,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            state.news[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            state.news[index].description,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            // style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 24,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(DateFormat('EEE, d MMM')
                                        .format(state.news[index].publishedAt)),
                                    const Spacer(),
                                    InkWell(
                                        onTap: () {
                                          UtilityService.launch(
                                              state.news[index].url);
                                        },
                                        child: Text(
                                          "Open Link >",
                                          style: Theme.of(context)
                                              .textTheme
                                              .button
                                              ?.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                          if(!context.read<NewsListCubit>().bookmarked) Positioned(
                            right: 4,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<NewsListCubit>()
                                    .addInBookMark(state.news[index]);
                              },
                              child: Icon(
                                Icons.bookmark_add,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: state.news.length,
                ));
          case ViewState.error:
            return const Center(
              child: Text("Something Went Wrong. Please try later!!!"),
            );
          case ViewState.empty:
            return const Center(
              child: Text("No News Found"),
            );
        }
      },
    );
  }
}
