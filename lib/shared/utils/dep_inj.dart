import 'package:get_it/get_it.dart';

import '../../features/history/model/history_repository.dart';
import '../../features/home/model/home_repository.dart';
import '../../features/member_validation/model/member_validation_repository.dart';

class DepInj {
  static final GetIt locator = GetIt.instance;

  static void setup() {
    locator.registerLazySingleton(() => HomeRepository());
    locator.registerLazySingleton(() => HistoryRepository());
    locator.registerLazySingleton(() => MemberValidationRepository());

    // Register shared services and blocs here, e.g.
    // locator.registerLazySingleton<AuthenticationBloc>(
    //   () => AuthenticationBloc(),
    // );
  }
}
