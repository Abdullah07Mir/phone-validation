import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_validations/cubit/auth_cubit.dart';
import 'package:phone_validations/cubit/auth_cubit_state.dart';
import 'package:phone_validations/screens/otp.dart';

class Signin extends StatelessWidget {
  // Controller for the text field
  final TextEditingController _textFieldController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text field
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Enter number',
                ),
              ),
            ),

            // Button
            BlocConsumer<AuthCubit, AuthCubitState>(
              listener: (context, state) {
                if(state is AuthSentState){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    BlocProvider(create: (context) => AuthCubit(),child: OtpScreen(),),
                  ));
                }
              },
              builder: (context, state) {
                if(state is AuthLoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    String phoneNumber = '+92'+phoneController.text;
                    BlocProvider.of<AuthCubit>(context).sendOtp(phoneNumber);
                    // Do something with the entered text, e.g., display it in a dialog
                  },
                  child: Text('Signin'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
