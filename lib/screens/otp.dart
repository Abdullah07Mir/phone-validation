import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validations/cubit/auth_cubit.dart';
import 'package:phone_validations/cubit/auth_cubit_state.dart';
import 'package:phone_validations/screens/HomeScreen.dart';

class OtpScreen extends StatelessWidget {
  // Controller for the text field
  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: otpController,
                decoration: InputDecoration(
                  labelText: 'Enter Otp',
                ),
              ),
            ),

            // Button
            BlocConsumer<AuthCubit, AuthCubitState>(
              listener: (context, state) {
                if (state is AuthLoggedinState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthCubit(),
                          child: HomeScreen(),
                        ),
                      ));
                } else if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMsg),
                    duration: Duration(milliseconds: 2000),
                  ));
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context)
                        .verifyOtp(otpController.text);
                  },
                  child: Text('Submit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
