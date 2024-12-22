import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learnify/core/constants/api_config.dart';
import 'package:learnify/features/auth/repository/auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;
  SignInBloc(this.authRepository) : super(SignInInitial()) {
    on<SignInRequired>(_signIn);
  }

  Future<void> _signIn(SignInRequired event, Emitter<SignInState> emit) async {
    emit(SignInProcess());
    try{
      final signInData = await authRepository.signIn(event.email, event.password);
      token = signInData['data']?['accessToken']??'';
      emit(SignInSuccess());
    }catch(e){
      emit(SignInFailure());
    }
  }
}
