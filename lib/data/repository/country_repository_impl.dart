import 'package:assessment/domain/entities/country.dart';
import 'package:assessment/domain/repositories/country_repository.dart';
import 'package:injectable/injectable.dart';
import '../api/country_api_service.dart';
import '../local/favorites_storage.dart';
import '../models/country_model.dart';


@injectable
class CountryRepositoryImpl implements CountryRepository {
  final CountryApiService _apiService;

  CountryRepositoryImpl(this._apiService);

  @override
  Future<List<Country>> fetchCountries() async {
    final countries = await _apiService.fetchCountries();
    final favoriteNames = await FavoritesStorage.loadFavorites();
    return countries.map((model) => Country(
          name: model.name,
          population: model.population,
          flag: model.flag,
          flags: model.flags,
          area: model.area,
          region: model.region,
          subregion: model.subregion,
          timezones: model.timezones,
          isFavorite: favoriteNames.contains(model.name),
        )).toList();
  }

  @override
  Future<void> saveFavorites(List<Country> countries) async {
    final models = countries.map((c) => CountryModel(
          name: c.name,
          population: c.population,
          flag: c.flag,
          flags: c.flags,
          area: c.area,
          region: c.region,
          subregion: c.subregion,
          timezones: c.timezones,
          isFavorite: c.isFavorite,
        )).toList();
    await FavoritesStorage.saveFavorites(models);
  }

  @override
  Future<List<String>> loadFavorites() async {
    return await FavoritesStorage.loadFavorites();
  }
}