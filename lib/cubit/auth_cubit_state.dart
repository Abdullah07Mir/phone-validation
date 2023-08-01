import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthCubitState{

}

class AuthInitialState extends AuthCubitState{

} 
class AuthSentState extends AuthCubitState{}

class AuthVerifiedState extends AuthCubitState{}

class AuthLoggedinState extends AuthCubitState{
  final User firebaseUser;
  AuthLoggedinState(this.firebaseUser);
}

class AuthLoggedoutState extends AuthCubitState{
}

class AuthErrorState extends AuthCubitState{
  final String errorMsg;
  AuthErrorState(this.errorMsg);

}

class AuthLoadingState extends AuthCubitState{
  
}