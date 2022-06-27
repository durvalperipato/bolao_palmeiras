import 'dart:developer';

import 'package:bolao_palmeiras/services/auth/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> signIn() async {
    try {
      emit(state.copyWyth(status: LoginStatus.loading));
      await _authService.signIn();
      emit(state.copyWyth(status: LoginStatus.success));
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWyth(
          status: LoginStatus.failure, errorMessage: 'Erro ao realizar login'));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
