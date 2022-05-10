import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {}

class UnAuthState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
