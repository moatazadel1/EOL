import 'package:eol/core/local_data/shared_preferences_services.dart';
import 'package:eol/core/localization/app_localization.dart';
import 'package:eol/services/community_services.dart';
import 'package:eol/views/community/providers/comments_provider.dart';
import 'package:eol/views/community/providers/community_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

class DependencyInjectionServices {
  init() async {
    /// Shared Preferences  initialize
    await sharedPreferencesInit();

    /// Localization  initialize
    localizationInit();

    /// initialize community
    initializeCommunuty();
  }

  sharedPreferencesInit() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton<SharedPreferencesServices>(
        () => SharedPreferencesServicesImpl(prefs: sl()));
  }

  void localizationInit() {
    sl.registerLazySingleton<BaseAppLocalizations>(() => AppLocalizations());
  }

  initializeCommunuty() {
    sl.registerFactory(() => CommunityProvider(communityServices: sl()));
    sl.registerFactory(() => CommentsProvider(communityServices: sl()));
    sl.registerLazySingleton(() => CommunityServices());
  }
}
