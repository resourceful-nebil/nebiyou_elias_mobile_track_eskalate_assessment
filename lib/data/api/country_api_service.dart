import 'dart:convert';
import 'package:assessment/core/error.dart';
import 'package:http/http.dart' as http;
import '../models/country_model.dart';

class CountryApiService {
  static const String _baseUrl = 'https://restcountries.com/v3.1/independent?status=true&fields=name,population,flag,area,region,subregion,timezones,flags';

  Future<List<CountryModel>> fetchCountries() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CountryModel.fromJson(json)).toList();
      } else {
        throw AppError('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw AppError('Error fetching countries: $e');
    }
  }
}