import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/src/app/cubit/app_cubit.dart';
import 'package:news_test/src/app/cubit/app_state.dart';
import 'package:news_test/src/infra/services/storage_service.dart';

import '../../modules/auth/views/auth_view.dart';
import '../../modules/dashboard/views/dashboard_view.dart';
import '../../modules/splash/splash_view.dart';
 final  GlobalKey<NavigatorState> navigatorKey =  GlobalKey<NavigatorState>();
class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppCubit>(
      create: (context) => AppCubit(service: StorageService())..checkAuthentication(),
      child: MaterialApp(
        title: 'News App',
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Builder(
          builder: (context) {
            return BlocBuilder<AppCubit, AppState>(
              builder: (context, state) {
                switch (state.eAppState) {
                  case EAppState.loggedIn:
                    return DashboardView.getWidget();
                  case EAppState.loggedOut:
                    return AuthView.getWidget();
                  case EAppState.notDetermined:
                    return const SplashView();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
