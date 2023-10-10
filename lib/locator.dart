import 'package:get_it/get_it.dart';
import 'package:mvc_exp/services/user_data_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<UserDataService>(() => UserDataService());
}
