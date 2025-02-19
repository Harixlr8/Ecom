import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_verifyUser/verifyuser_bloc.dart';
import 'package:test_zybo/layers/login/screens/otp_screen.dart';
import 'package:test_zybo/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => VerifyuserBloc(),
      child: Scaffold(
        appBar: AppBar(),
        // backgroundColor: Colors.black,
        body: BlocConsumer<VerifyuserBloc, VerifyuserState>(
          listener: (context, state) {
            if (state is VerifyUserSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OtpScreen(otp: state.response.otp),
                ),
              );
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text("OTP: ${state.response.otp}")),
              // );
            } else if (state is VerifyUserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is VerifyUserLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // SizedBox(height: size.height*0.2,),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Let’s Connect with Lorem Ipsum..!",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: size.width * 0.1,
                            decoration: BoxDecoration(
                                // border: Border(bottom: BorderSide())
                                ),
                            child: Text('+ 91'),
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: "Enter Phone",
                            border: const UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: "Continue",
                    onPressed: () {
                      final phoneNumber = phoneController.text.trim();
                      if (phoneNumber.isNotEmpty) {
                        context
                            .read<VerifyuserBloc>()
                            .add(VerifyUserRequest(phoneNumber));
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "By Continuing you accepting the ",
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 12),
                        children: [
                          TextSpan(
                            text: "Terms of Use &",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          const TextSpan(text: " "),
                          TextSpan(
                            text: "Privacy Policy",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
