import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_news_app/src/blocs/auth/auth_events.dart';
import 'package:flutter_news_app/src/blocs/auth/auth_state.dart';
import 'package:flutter_news_app/src/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthState()) {
    on<SignInRequested>(((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthState());
      }
    }));
    on<SignUpRequested>(((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.signUp(
            email: event.email, password: event.password);
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthState());
      }
    }));
    on<GoogleSignInRequested>(((event, emit) async {
      emit(AuthLoadingState());
      try {
        await authRepository.sigInWithGoogle();
        emit(AuthenticatedState());
      } catch (e) {
        emit(AuthErrorState(e.toString()));
        emit(UnAuthState());
      }
    }));
    on<SignOutRequested>(((event, emit) async {
      emit(AuthLoadingState());
      await authRepository.signOut();
      emit(UnAuthState());
    }));
  }
}
