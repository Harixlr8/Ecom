part of 'verifyuser_bloc.dart';

sealed class VerifyuserState extends Equatable {
  const VerifyuserState();
  
  @override
  List<Object> get props => [];
}

final class VerifyuserInitial extends VerifyuserState {}

class VerifyUserInitial extends VerifyuserState {}

class VerifyUserLoading extends VerifyuserState {}

class VerifyUserSuccess extends VerifyuserState {
  final VerifyUserResponse response;

  const VerifyUserSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class VerifyUserFailure extends VerifyuserState {
  final String error;

  const VerifyUserFailure(this.error);

  @override
  List<Object> get props => [error];
}

