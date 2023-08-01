import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validations/cubit/auth_cubit.dart';
import 'package:phone_validations/cubit/auth_cubit_state.dart';
import 'package:phone_validations/screens/signin.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthCubit, AuthCubitState>(
          listener: (context, state) {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => AuthCubit(),
                    child: Signin(),
                  ),
                ));
          },
          builder: (context, state) {
            return TextButton(
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).signout();
                },
                child: Text('Signout'));
          },
        ),
      ),
    );
  }
}
