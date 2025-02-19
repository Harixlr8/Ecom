import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_zybo/model/profile_model.dart';
import 'package:test_zybo/data/service/api_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileFetchEvent>(profileFetchEvent);
  }
 Future<void> profileFetchEvent(
    ProfileFetchEvent event, Emitter<ProfileState> emit) async {
  emit(ProfileInitial());

  try {
    UserProfile? profile = await ApiService().fetchUserProfile();

    if (profile != null) {
emit(ProfileDetailsFetched(profile: profile));
    } else {
      
    }
  } catch (e) {
    emit(ProfileError(error: "Error: $e"));
  }
}
}