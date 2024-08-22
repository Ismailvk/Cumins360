// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cumins36/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupUserEvent>(signupUser);
  }

  FutureOr<void> signupUser(
      SignupUserEvent event, Emitter<SignupState> emit) async {
    emit(SignupLoadingState());
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      User? user = (await auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password))
          .user;
      if (user != null) {
        user.updateProfile(displayName: event.name);
        await firestore.collection('user').doc(auth.currentUser?.uid).set({
          "name": event.name,
          "email": event.email,
          "status": "Unavailable",
          "uid": auth.currentUser?.uid,
        });
        Navigator.of(event.context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        emit(SignupFailedState(message: 'Account Creation Failed'));
      }
    } catch (e) {
      emit(SignupFailedState(message: e.toString()));
    }
  }
}
