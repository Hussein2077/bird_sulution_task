import 'package:flutter_task/features/auth/data/auth_remote_data_source.dart';
import 'package:flutter_task/features/auth/data/repo_imp.dart';
import 'package:flutter_task/features/auth/domain/repo/base_repo.dart';
import 'package:flutter_task/features/auth/domain/use_case/login_with_email_and_password_use_case.dart';
import 'package:flutter_task/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc
    getIt.registerLazySingleton<BaseRemotelyDataSource>(
        () => AuthRemotelyDateSource());
    getIt.registerLazySingleton<BaseRepository>(
        () => RepositoryImp(baseRemotelyDataSource: getIt()));
    getIt.registerFactory(() => LoginWithEmailAndPasswordBloc(
        loginWithEmailAndPasswordUseCase: getIt()));
    getIt.registerLazySingleton(
        () => LoginWithEmailAndPasswordUseCase(baseRepository: getIt()));

//use_case
  }
}
