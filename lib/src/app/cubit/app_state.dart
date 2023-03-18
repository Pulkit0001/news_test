import '../../data/models/user_data_mode.dart';

class AppState {
  final EAppState eAppState;
  final UserData? user;

  AppState({required this.eAppState, this.user});

  factory AppState.initial() => AppState(eAppState: EAppState.notDetermined);

  AppState copyWith({EAppState? eAppState, UserData? user}) =>
      AppState(eAppState: eAppState ?? this.eAppState, user: user ?? this.user);
}

enum EAppState {
  loggedIn,
  loggedOut,
  notDetermined,
}
