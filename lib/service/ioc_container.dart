import 'package:dartboard/service/invite_service.dart';
import 'package:dartboard/service/setup_user_service.dart';
import 'package:dartboard/service/statistic_service.dart';
import 'package:get_it/get_it.dart';

final get = GetIt.instance;

class IoCContainer {
  Future<void> setup() async {
    get.registerSingleton(
      StatisticService(),
    );
    get.registerSingleton(
      SetupUserService(),
    );
    get.registerSingleton(
      InviteService(),
    );
  }
}
