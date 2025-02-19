import 'package:equatable/equatable.dart';
import 'package:test_zybo/model/login_register_model.dart';

abstract class LoginRegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRegisterInitial extends LoginRegisterState {}

class LoginRegisterLoading extends LoginRegisterState {}

class LoginRegisterSuccess extends LoginRegisterState {
  final LoginRegisterResponse response;

  LoginRegisterSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class LoginRegisterFailure extends LoginRegisterState {
  final String error;

  LoginRegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}
