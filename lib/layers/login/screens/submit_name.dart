import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/service/shared_pref_service.dart';
import 'package:test_zybo/layers/home/screen/main_home.dart';
import 'package:test_zybo/data/bloc/bloc_submitlogin/submitlogin_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_submitlogin/submitlogin_event.dart';
import 'package:test_zybo/data/bloc/bloc_submitlogin/submitlogin_state.dart';
import 'package:test_zybo/widgets/back_arrow.dart';
import 'package:test_zybo/widgets/custom_button.dart';

class SubmitName extends StatefulWidget {
  const SubmitName({super.key});

  @override
  State<SubmitName> createState() => _SubmitNameState();
}

class _SubmitNameState extends State<SubmitName> {
  String? phoneNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPhoneNumber();
  }

  Future<void> _loadPhoneNumber() async {
    String? savedPhone = await SharedPrefService.getPhoneNumber();
    setState(() {
      phoneNumber = savedPhone; // Set state to update UI
    });
  }

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
          child: BackArrow(),
        ),
      ),
      body: BlocProvider(
        create: (context) => LoginRegisterBloc(),
        child: BlocConsumer<LoginRegisterBloc, LoginRegisterState>(
          listener: (context, state) {
            print("Current statae $state");
            if (state is LoginRegisterSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainHome()));
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: "Enter Name",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: "Submit",
                      onPressed: () {
                        String firstName = nameController.text.trim();

                        if (firstName.isNotEmpty &&
                            (phoneNumber?.isNotEmpty ?? false)) {
                          context.read<LoginRegisterBloc>().add(
                            SubmitLoginRegister(
                              firstName: firstName,
                              phoneNumber: phoneNumber!,
                            ),
                          );
                        }
                      })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
