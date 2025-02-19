import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/service/api_service.dart';
import 'package:test_zybo/data/bloc/bloc_submitlogin/submitlogin_event.dart';
import 'package:test_zybo/data/bloc/bloc_submitlogin/submitlogin_state.dart';


class LoginRegisterBloc extends Bloc<LoginRegisterEvent, LoginRegisterState> {


  LoginRegisterBloc() : super(LoginRegisterInitial()) { 
    on<SubmitLoginRegister>(_onSubmitLoginRegister);
  }

  Future<void> _onSubmitLoginRegister(SubmitLoginRegister event, Emitter<LoginRegisterState> emit) async {


    emit(LoginRegisterLoading());

    try {
      final response = await ApiService().loginOrRegister(event.firstName, event.phoneNumber);

      emit(LoginRegisterSuccess(response));

    } catch (e) {
      emit(LoginRegisterFailure(e.toString()));
    }
  }
}
