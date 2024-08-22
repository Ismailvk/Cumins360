// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cumins36/data/shared_preference.dart';
import 'package:cumins36/view/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>(loginUser);
  }

  FutureOr<void> loginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      User? user = (await auth.signInWithEmailAndPassword(
              email: event.email, password: event.password))
          .user;

      if (user != null) {
        SharedPreference.instance.storeToken('1');
        Navigator.of(event.context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false);
      } else {
        emit(LoginErrorSate(message: "Login Failed"));
      }
    } catch (e) {
      emit(LoginErrorSate(message: e.toString()));
    }
  }
}
