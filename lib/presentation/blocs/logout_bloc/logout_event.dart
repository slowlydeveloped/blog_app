part of 'logout_bloc.dart';


sealed class LogoutEvent extends Equatable {
  final BuildContext context;
   LogoutEvent(this.context);


  @override
  List<Object> get props => [];
}

class UserRequestedLogout extends LogoutEvent{
   UserRequestedLogout(BuildContext context): super(context);
}