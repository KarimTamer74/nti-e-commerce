import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  Logger logger = Logger();
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.d('🔍 Bloc Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.f('🔁 Bloc Change in ${bloc.runtimeType}: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('❌ Bloc Error in ${bloc.runtimeType}: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logger.t('🛑 Bloc Closed: ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
