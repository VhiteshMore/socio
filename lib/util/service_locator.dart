
import 'package:get_it/get_it.dart';
import 'package:socio/data/repo/onboarding/onboarding_repo.dart';
import 'package:socio/data/repo/onboarding/onboarding_repo_impl.dart';
import 'package:socio/util/user_data_helper.dart';

import '../bloc/session_bloc.dart';

GetIt injector = GetIt.instance;

Future<void> init() async {

  injector.registerFactory<OnBoardingRepoImpl>(() => OnBoardingRepoImpl(),);

  injector.registerLazySingleton<UserDataHelper>(() => UserDataHelper());
  injector.registerLazySingleton<SessionBloc>(() => SessionBloc());

}
