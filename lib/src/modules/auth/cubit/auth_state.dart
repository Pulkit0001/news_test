import 'package:news_test/src/utils/enums.dart';

class AuthState {
  final CustomFormState formState;
  final String? message;

  AuthState({required this.formState, this.message});

  factory AuthState.initial() => AuthState(formState: CustomFormState.idle);

  AuthState copyWith({CustomFormState? formState, String? message}) =>
      AuthState(
        formState: formState ?? this.formState,
        message: message ?? this.message,
      );
}
