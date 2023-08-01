import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validations/cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState()){
  User? currentUser = _auth.currentUser;
  if(currentUser != null){
    emit(AuthLoggedinState(currentUser));
  }
  else{
    emit(AuthLoggedoutState());
  }
  }
  String? _verificationId;


  void sendOtp(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeSent: (verificationId, forceResendingToken) {
        _verificationId = verificationId;
        emit(AuthSentState());
      },
      verificationCompleted: (phoneAuthCredential) {
        signinWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(error.message.toString()));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  void verifyOtp(String otp) async {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
    signinWithPhone(credential);
  }

  void signinWithPhone(PhoneAuthCredential credential) async {
    try{
      UserCredential userCredential= await _auth.signInWithCredential(credential);
      if(userCredential.user != null){
        emit(AuthLoggedinState(userCredential.user!));
      }
    }on FirebaseAuthException catch(ex){
      emit(AuthErrorState(ex.message.toString()));
    }
  }

  void signout()async {
    await _auth.signOut();
    emit(AuthLoggedoutState());
  }

}
