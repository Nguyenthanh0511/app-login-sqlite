import 'package:bloc/bloc.dart';
import 'package:nguyen_trung_thanh/base_log.dart';
import 'package:nguyen_trung_thanh/login_event.dart';
import 'package:nguyen_trung_thanh/login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    // on<LoginUsernameChanged>(_onUsernameChanged);
    // on<LoginPasswordChanged>(_onPasswordChanged);
    // on<LoginSubmitted>(_onSubmitted);
  }
  @override
  Future<void> handleEvent(LoginEvent event, Emitter<LoginState> emit) async{
    try{
      if(event is LoginUsernameChanged){
        emit(state.copyWith(username: event.username));
      }else if(event is LoginPasswordChanged){
        emit(state.copyWith(password: event.password));
      }else if(event is LoginSubmitted){
        emit(state.copyWith(isLoading: true, error: null));

        await Future.delayed(const Duration(seconds:1)); // Giaar tưởng đang đợi trả về

        if(event.username == 'admin' && event.password == 'password'){
          emit(state.copyWith(isLoading: false, isSuccess: true));
        }
        else{
          throw Exception('Thông tin đăng nhập không chính xác!');
        }
      }
    }catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
      rethrow; // Để BaseBloc handle và log lỗi
    }
  }

  /*
  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(username: event.username));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      // Thêm logic xác thực ở đây
      await Future.delayed(const Duration(seconds: 2)); // Demo delay
      
      // Xử lý matching name và password
      if (event.username == 'admin' && event.password == 'password') {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      } else {
        emit(state.copyWith(
          isLoading: false,
          error: 'Tên đăng nhập hoặc mật khẩu không đúng',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Đã xảy ra lỗi: ${e.toString()}',
      ));
    }
  }
  */

}