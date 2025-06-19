import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'data/api/country_api_service.dart';
import 'data/repository/country_repository_impl.dart';
import 'domain/repositories/country_repository.dart';
import 'domain/usecases/fetch_countries.dart';
import 'presentation/bloc/country_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton<http.Client>(() {
    return http.Client();
  });

  // Data sources
  sl.registerLazySingleton(() => CountryApiService());

  // Repositories
  sl.registerLazySingleton<CountryRepository>(
    () => CountryRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => FetchCountries(sl()));

  // Blocs
  sl.registerFactory(() => CountryBloc(
        sl(),
      ));
}