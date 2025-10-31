abstract class AuthState {}

class AuthInitial extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterFailureState extends AuthState {}

class RegisterSuccssState extends AuthState {}
