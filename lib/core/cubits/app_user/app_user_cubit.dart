import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_asap/core/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(PortalNewsUser? user) {
    if (user == null) {
      emit(AppUserInitial());
    } else {
      emit(AppUserLoggedIn(user));
    }
  }
}
