import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:my_learning/pantry/repos/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthCheckRequested>(authCheckRequested);
    on<AuthSignedIn>(authSignedIn);
    on<AuthSignedUp>(authSignedUp);
    on<AuthSignedOut>(authSignedOut);
    on<UpdateUserCredentials>(updateUserCredentials);
  }
  FutureOr<void> authCheckRequested (AuthCheckRequested event, Emitter<AuthState> emit) async {
    final user = authRepository.user;
    await emit.forEach(user, onData: (user) {
      return user != null ? Authenticated(user) : Unauthenticated();
    });
  }
  FutureOr<void> authSignedIn(AuthSignedIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print("State: $state");
    try {
      await authRepository.signInWithEmailAndPassword(event.email, event.password);
      emit(Authenticated(await authRepository.currentUser!));
      print("User: ${authRepository.currentUser}");
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  FutureOr<void>authSignedUp(AuthSignedUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signUpWithEmailAndPassword(event.email, event.password);
      emit(Authenticated(await authRepository.currentUser!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
  FutureOr<void>authSignedOut(AuthSignedOut event, Emitter<AuthState> emit) async {
    await authRepository.signOut();
    emit(Unauthenticated());
  }

  FutureOr<void>updateUserCredentials(UpdateUserCredentials event, Emitter<AuthState> emit) async {
    await authRepository.updateUserProfile(
      userName: event.userName,
      photoURL: event.image,
    );
    emit(Authenticated(await authRepository.currentUser!));
  }
}
