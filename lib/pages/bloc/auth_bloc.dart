import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async{
      if (event is LoginEvent) {
        emit(LoginLoading());
    try {
      // ignore: unused_local_variable
      UserCredential auth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: event.email, password: event.password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'INVALID_LOGIN_CREDENTIALS') {
        emit(LoginFailure(errMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
            LoginFailure(errMessage: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'There was an error.'));
    }
      }
    });
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    
    super.onTransition(transition);

    print('tansition in auth bloc   $transition');
  }

  @override
  void onChange(Change<AuthState> change) {
    
    super.onChange(change);

    print('change in auth bloc   $change');
  }


}
