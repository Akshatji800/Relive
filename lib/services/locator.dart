import 'package:get_it/get_it.dart';
import 'package:mental_health/services/firebase_service.dart';
import 'package:mental_health/services/storage_repo.dart';
import 'package:mental_health/services/user_controller.dart';

final locator = GetIt.instance;

String setupServices()  {
  locator.registerSingleton<FirebaseService>(FirebaseService());
  locator.registerSingleton<StorageRepo>(StorageRepo());
  locator.registerSingleton<UserController>(UserController());
  return "";
}