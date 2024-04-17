// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequiredEvent extends SignInEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const SignInRequiredEvent({
    required this.email,
    required this.password,
    this.rememberMe = false,
  });
}
