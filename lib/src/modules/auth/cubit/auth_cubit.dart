import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/src/app/cubit/app_cubit.dart';
import 'package:news_test/src/app/cubit/app_state.dart';
import 'package:news_test/src/infra/services/auth_sevice.dart';
import 'package:news_test/src/infra/services/storage_service.dart';
import 'package:news_test/src/modules/auth/cubit/auth_state.dart';
import 'package:news_test/src/utils/enums.dart';

import '../../../app/views/app.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authService, this.service) : super(AuthState.initial());

  final AuthService authService;
  final StorageService service;

  Future<void> googleSignIn() async {
    try {
      emit(state.copyWith(
          formState: CustomFormState.uploading,
          message: "Authenticating via Google"));
      var res = await authService.googleSignIn();
      await service.saveUserData(res);
      emit(state.copyWith(
          formState: CustomFormState.success,
          message: "You logged in successfully"));

    } catch (e) {
      emit(state.copyWith(
          formState: CustomFormState.error,
          message: "Sign In Failed!!!"));
    }
  }
}
