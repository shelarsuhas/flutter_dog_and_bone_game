import 'package:get_it/get_it.dart';
import 'package:stacked_services/stacked_services.dart';

var locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<DialogService>(() => DialogService());
}
