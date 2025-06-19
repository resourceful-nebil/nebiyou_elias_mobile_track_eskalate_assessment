import 'package:assessment/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/country_model.dart';

class FavoritesStorage {
  static Future<void> saveFavorites(List<CountryModel> countries) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteNames = countries.where((c) => c.isFavorite).map((c) => c.name).toList();
    print('Saving favorites: $favoriteNames'); // Debug
    await prefs.setStringList(favoritesKey, favoriteNames);
  }

  static Future<List<String>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(favoritesKey) ?? [];
  }
}