import 'package:equatable/equatable.dart';

abstract class LoginRegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitLoginRegister extends LoginRegisterEvent {
  final String firstName;
  final String phoneNumber;

  SubmitLoginRegister({required this.firstName, required this.phoneNumber});

  @override
  List<Object?> get props => [firstName, phoneNumber];
}
