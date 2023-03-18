import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/src/app/cubit/app_state.dart';
import 'package:news_test/src/infra/services/storage_service.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required this.service}) : super(AppState.initial());

  final StorageService service;

  void checkAuthentication() async {
    try {
      var res = await service.getUserData();
      emit(state.copyWith(eAppState: EAppState.loggedIn, user: res));
    } catch (e) {
      emit(state.copyWith(eAppState: EAppState.loggedOut));
    }
  }
}
