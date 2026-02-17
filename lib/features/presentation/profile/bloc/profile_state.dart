part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  userInfoSuccess,
  userInfoFailed,

  /// Eğer kullanıcının doğum günüyse tetiklenecek.
  usersBirthday,
}

class ProfileState extends Equatable {
  const ProfileState({
    this.status = ProfileStatus.initial,
    this.userInfo,
  });

  final ProfileStatus status;
  final UserInfo? userInfo;

  ProfileState copyWith({
    ProfileStatus? status,
    UserInfo? userInfo,
  }) {
    return ProfileState(
      status: status ?? this.status,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object> get props => [
        status,
        userInfo ?? "",
      ];
}
