import 'package:get_it/get_it.dart';

class DepInj {
  static final GetIt locator = GetIt.instance;

  static void setup() {
    // Register shared services and blocs here, e.g.
    // locator.registerLazySingleton<AuthenticationBloc>(
    //   () => AuthenticationBloc(),
    // );
  }
}
