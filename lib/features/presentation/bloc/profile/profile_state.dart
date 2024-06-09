class ProfileState<T> {
  final bool isInitial;
  final bool isInProgress;
  final bool isFailure;
  final bool isInfoLogin;
  final bool isLogout;
  final bool isLogin;

  final String? message;

  const ProfileState({
    this.isInitial = false,
    this.isInProgress = false,
    this.isFailure = false,
    this.isLogout = false,
    this.isInfoLogin = false,
    this.isLogin = false,
    this.message = '',
  });

  factory ProfileState.initial() => const ProfileState(isInitial: true);

  factory ProfileState.inProgress() => const ProfileState(isInProgress: true);

  factory ProfileState.failure(String? message) =>
      ProfileState(isFailure: true, message: message);

  factory ProfileState.loginInfo({required bool isLogin}) =>
      ProfileState(isInfoLogin: true, isLogin: isLogin);

  factory ProfileState.logout() => const ProfileState(isLogout: true);
}
