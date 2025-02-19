import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:test_zybo/layers/login/screens/submit_name.dart';
import 'package:test_zybo/widgets/back_arrow.dart';
import 'package:test_zybo/widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  final String otp;
  const OtpScreen({super.key, required this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String enteredOtp = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(10,5,5,5),
          child: BackArrow(),
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OTP VERIFICATION",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text("Enter the OTP Sent to +91 *******"),
            SizedBox(
              height: 25,
            ),
            Text(
              "OTP is ${widget.otp}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Pinput(
              length: 4, // 4-digit OTP
              onChanged: (value) => enteredOtp = value, // Store entered OTP
              onCompleted: (value) => enteredOtp = value, // Update on complete
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("00:000 Sec"),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive code?"),
                  Text(
                    "Re-send",
                    style: TextStyle(color: Colors.cyan),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
                text: "Submit",
                onPressed: () {
                  if (enteredOtp == widget.otp) {
                    _showMessage("OTP Verified Successfully!", Colors.green);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubmitName(),
                      ),
                    );
                  } else {
                    _showMessage("Invalid OTP! Please try again.", Colors.red);
                  }
                }),
          ],
        ),
      ),
    );
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
