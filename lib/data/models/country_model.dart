import '../../domain/entities/country.dart';

class CountryModel extends Country {
  CountryModel({
    required String name,
    required int population,
    required String flag,
    Map<String, String>? flags,
    Map<String, Map<String, String>>? nativeName,
    int? area,
    String? region,
    String? subregion,
    List<String>? timezones,
    bool isFavorite = false,
  }) : super(
          name: name,
          population: population,
          flag: flag,
          flags: flags,
          nativeName: nativeName,
          area: area,
          region: region,
          subregion: subregion,
          timezones: timezones,
          isFavorite: isFavorite,
        );

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name']['common'] as String,
      population: json['population'] as int,
      flag: json['flag'] as String,
      flags: json['flags'] != null
          ? {
              'png': json['flags']['png'] as String,
              'svg': json['flags']['svg'] as String,
              'alt': json['flags']['alt'] as String,
            }
          : null,
      nativeName: json['name']['nativeName'] != null
          ? {for (var entry in (json['name']['nativeName'] as Map).entries) entry.key: {'official': entry.value['official'] as String, 'common': entry.value['common'] as String}}
          : null,
      area: (json['area'] as num?)?.toInt(),
      region: json['region'] as String?,
      subregion: json['subregion'] as String?,
      timezones: (json['timezones'] as List<dynamic>?)?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': {'common': name, 'nativeName': nativeName},
      'population': population,
      'flag': flag,
      'flags': flags,
      'area': area,
      'region': region,
      'subregion': subregion,
      'timezones': timezones,
    };
  }
}