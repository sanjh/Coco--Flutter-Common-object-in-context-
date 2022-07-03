import 'package:coco_mobile/domain_layer/other_cases/search_coco_dataset.dart';
import 'package:coco_mobile/provider/search_provider.dart';
import 'package:get_it/get_it.dart';
import 'core/api/api_handling.dart';
import 'core/network/network.dart';
import 'data_layer/datasources/datasource.dart';
import 'data_layer/repositories/repository_implement.dart';
import 'domain_layer/repositories/search_repository.dart';
import 'bloc/coco_bloc.dart';

final servLocator = GetIt.instance;

void init() {
  servLocator.registerLazySingleton<Network>(() => NetworkImplement());
  servLocator.registerLazySingleton<ApiBasic>(() => ApiHandler());

  servLocator.registerLazySingleton(() => SearchProvider());

  servLocator.registerFactory(
    () => CocoBloc(searchCocoDataset: servLocator()),
  );

  servLocator.registerLazySingleton(
    () => SearchCocoDataset(repository: servLocator()),
  );

  servLocator.registerLazySingleton<SearchRepository>(
    () => RepositoryImplement(remoteDataSource: servLocator()),
  );

  servLocator.registerLazySingleton<CocoDataSource>(
    () => SearchDataSourceImplement(
      apiHandler: servLocator(),
      networkInfo: servLocator(),
    ),
  );
}
