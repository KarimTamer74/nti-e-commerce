import 'dart:developer';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(Locale('ar'));
  void chnageLanguage(String code) {
    log("Current Language: $code");
    emit(Locale(code));
  }
}
