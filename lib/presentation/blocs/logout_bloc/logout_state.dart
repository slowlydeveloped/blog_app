part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();
  
  @override
  List<Object> get props => [];
}

final class LogoutInitial extends LogoutState {}

class LogoutSuccess extends LogoutState{}

class LogoutFailure extends LogoutState{
  final String error;
  const LogoutFailure(this.error);
}