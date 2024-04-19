import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:blog_app/presentation/routers/router_imports.gr.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutBloc() : super(LogoutInitial()) {
    on<UserRequestedLogout>((event, emit) async{
      final  prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLogged');
      emit(LogoutSuccess());
      AutoRouter.of(event.context).replace(const LoginRoute());
    });
  }
}
