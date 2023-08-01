import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validations/cubit/auth_cubit.dart';
import 'package:phone_validations/cubit/auth_cubit_state.dart';
import 'package:phone_validations/screens/HomeScreen.dart';
import 'package:phone_validations/screens/signin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: BlocBuilder<AuthCubit, AuthCubitState>(
          buildWhen: (previous, current) {
            return previous is AuthInitialState;
          },
          builder: (context, state) {

            if(state is AuthLoggedinState){
              return HomeScreen();
            }
            else if(state is AuthLoggedoutState){
              return Signin();
            }
            else{
              return Signin();
            }

          },
          
        ),
      ),
    );
  }
}
