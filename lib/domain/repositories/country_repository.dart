import '../entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> fetchCountries();
  Future<void> saveFavorites(List<Country> countries);
  Future<List<String>> loadFavorites();
}