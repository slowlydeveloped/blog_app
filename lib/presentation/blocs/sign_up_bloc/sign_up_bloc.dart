import 'package:bloc/bloc.dart';
import 'package:blog_app/data/models/user_model.dart';
import '/data/data_sources/remote/my_sqlite.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final DataBaseHelper _dataBaseHelper;
  SignUpBloc(DataBaseHelper dataBaseHelper) : 
  _dataBaseHelper= dataBaseHelper,
  super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProgress());
      try {
        final isSignUpSuccessful = await _dataBaseHelper.signup(Users(
          email: event.email,
          password: event.password,
        ));
        
        if (isSignUpSuccessful > 0) {
          emit(SignUpSuccess());
        } else {
          emit(const SignUpFailure("Invalid error occured"));
        }
      } catch (e) {
        emit(SignUpFailure("Invalid error occured $e"));
      }
    });
  }
}
