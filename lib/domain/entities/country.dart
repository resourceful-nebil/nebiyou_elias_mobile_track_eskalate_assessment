import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final int population;
  final String flag;
  final Map<String, String>? flags;
  final int? area;
  final String? region;
  final String? subregion;
  final List<String>? timezones;
  bool isFavorite;

  Country({
    required this.name,
    required this.population,
    required this.flag,
    this.flags,
    this.area,
    this.region,
    this.subregion,
    this.timezones,
    this.isFavorite = false,
  });

  @override
  List<Object?> get props => [name, population, flag, flags, area, region, subregion, timezones, isFavorite];
}