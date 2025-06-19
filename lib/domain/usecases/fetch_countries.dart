import 'package:injectable/injectable.dart';
import '../entities/country.dart';
import '../repositories/country_repository.dart';

@injectable
class FetchCountries {
  final CountryRepository _repository;

  FetchCountries(this._repository);

  Future<List<Country>> call() async {
    return await _repository.fetchCountries();
  }
}