import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/src/app/cubit/app_cubit.dart';
import 'package:news_test/src/modules/dashboard/cubit/dashboard_cubit.dart';
import 'package:news_test/src/modules/news/views/news_list_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);
  static Widget getWidget() => BlocProvider<DashboardCubit>(
        create: (_) => DashboardCubit(),
        child: const DashboardView(),
      );
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Hi! " +( context.read<AppCubit>().state.user?.email ?? ""), style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white),),
        bottom: TabBar(
        labelColor: Colors.white,
          unselectedLabelColor: Colors.black54,
          controller: tabController,
          tabs: const [
            Tab(
              text: 'HOME',
            ),
            Tab(
              text: 'BOOKMARKS',
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: TabBarView(
          controller: tabController,
          children:  [
            NewsListView.getWidget(),
            NewsListView.getWidget(bookmarked: true)
          ],
        ),
      ),
    );
  }
}
