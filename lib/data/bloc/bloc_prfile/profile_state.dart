part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileDetailsFetched extends ProfileState {
  final UserProfile profile;

  const ProfileDetailsFetched({required this.profile});
}

final class ProfileError extends ProfileState {
  final String error;

  const ProfileError({required this.error});
}
