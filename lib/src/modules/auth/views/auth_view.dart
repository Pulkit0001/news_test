import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_test/main.dart';
import 'package:news_test/src/infra/services/auth_sevice.dart';
import 'package:news_test/src/modules/auth/cubit/auth_cubit.dart';
import 'package:news_test/src/modules/auth/cubit/auth_state.dart';
import 'package:news_test/src/utils/enums.dart';
import 'package:news_test/src/utils/utility_service.dart';

import '../../../app/cubit/app_cubit.dart';
import '../../../infra/services/storage_service.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  static getWidget() => BlocProvider<AuthCubit>(
        create: (_) => AuthCubit(AuthService(), StorageService()),
        child: const AuthView(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (_, state) async {
        if (state.formState == CustomFormState.uploading) {
          loader.showLoader(context, message: state.message ?? "");
        } else {
          loader.hideLoader();
        }
        if (state.formState == CustomFormState.success) {
          if (kDebugMode) {
            print("Success ==========================================");
          }
          UtilityService.showMessage(context, state.message ?? "");
          context.read<AppCubit>().checkAuthentication();
        }
        if (state.formState == CustomFormState.error) {
          if (kDebugMode) {
            print("Error ==========================================");
          }
          UtilityService.showError(context, state.message ?? "");
        }
      },
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                onPressed: () {
                  context.read<AuthCubit>().googleSignIn();
                },
                color: Theme.of(context).primaryColor,
                child: const Text("Continue With Google"),
              )
            ],
          ),
        );
      },
    );
  }
}
