import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_zybo/model/verify_user_model.dart';
import 'package:test_zybo/data/service/api_service.dart';

part 'verifyuser_event.dart';
part 'verifyuser_state.dart';

class VerifyuserBloc extends Bloc<VerifyuserEvent, VerifyuserState> {

  VerifyuserBloc() : super(VerifyuserInitial()) {


    on<VerifyUserRequest>(_verifyUser);
  }
   Future<void> _verifyUser(
      VerifyUserRequest event, Emitter<VerifyuserState> emit) async {
    emit(VerifyUserLoading());

    try {
      final response = await ApiService().verifyUser(event.phoneNumber);
      if (response != null) {
        emit(VerifyUserSuccess(response));
      } else {
        emit(VerifyUserFailure("Failed to verify user"));
      }
    } catch (e) {
      emit(VerifyUserFailure("Error: $e"));
    }
  }
}

