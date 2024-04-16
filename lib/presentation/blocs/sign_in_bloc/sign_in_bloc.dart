import 'package:bloc/bloc.dart';
import 'package:blog_app/data/data_sources/remote/my_sqlite.dart';
import 'package:blog_app/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final DataBaseHelper _dataBaseHelper;
  SignInBloc(this._dataBaseHelper) : super(SignInInitial()) {
    on<SignInRequiredEvent>((event, emit) async {
      emit(SignInProgress());
      try {
        final isSignInSuccessful = await _dataBaseHelper
            .login(Users(email: event.email, password: event.password));
        if (isSignInSuccessful) {
          emit(SignInSuccess());
        } else {
          emit(const SignInFailure("Invalid Email and Password"));
        }
      } catch (e) {
        emit(SignInFailure("An error occurred $e"));
      }
    });
  }
}