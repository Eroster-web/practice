// ignore_for_file: prefer_const_constructors, avoid_print, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/auth/auth_error.dart';

import '../repositories/auth_repo.dart';
part 'app_event.dart';
part 'app_state.dart';
class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;

  AppBloc(this._authRepository)
      : super(AppStateLoggedOut(isLoading: false, successful: false)) {
    on<AppEventLogIn>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await _authRepository.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventLogOut>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await _authRepository.signOut();
        emit(AppStateLoggedOut(isLoading: false, successful: true));
      } on FirebaseAuthException catch (_) {}
    });

    on<AppEventRegister>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await _authRepository.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorRegister = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });

    on<AppEventResetPassword>((event, emit) async {
      emit(AppStateLoggedOut(isLoading: true, successful: false));
      try {
        await _authRepository.sendResetPasswordEmail(email: event.email);
        emit(AppStateLoggedIn(isLoading: false, successful: true));
      } on FirebaseAuthException catch (e) {
        print(e);
        authErrorlogin = e.toString();
        emit(AppStateLoggedOut(isLoading: false, successful: false));
      }
    });
  }
}