part of 'verifyuser_bloc.dart';

sealed class VerifyuserEvent extends Equatable {
  const VerifyuserEvent();

  @override
  List<Object> get props => [];
}
class VerifyUserRequest extends VerifyuserEvent {
  final String phoneNumber;

  VerifyUserRequest(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}