part of 'app_bloc.dart';

abstract class AppState extends Equatable {
  final bool isLoading;
  final bool successful;
  const AppState({required this.isLoading, required this.successful,});
}

class AppStateLoggedIn extends AppState {
  const AppStateLoggedIn({required isLoading, required successful,})
      : super(isLoading: isLoading, successful: successful);

  @override
  List<Object?> get props => [isLoading, successful];
}

class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({
    required isLoading,
    required successful,
  }) : super(
          isLoading: isLoading,
          successful: successful,
        );

  @override
  List<Object?> get props => [isLoading, successful];
}
