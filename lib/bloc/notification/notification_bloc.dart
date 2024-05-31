import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, bool> {
  NotificationBloc() : super(false) {
    _getPref();
    on<ChangeValue>((event, emit) async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool('notif', !state);

      emit(!state);
    });
  }
  // Future setPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('notif', !state);
  // }

  Future _getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getBool('notif') ?? false;
  }
}
