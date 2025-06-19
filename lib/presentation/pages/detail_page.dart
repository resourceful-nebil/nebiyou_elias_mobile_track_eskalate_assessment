import 'package:flutter/material.dart';
import '../../domain/entities/country.dart';
import '../../core/utils.dart' as utils;

class DetailPage extends StatelessWidget {
  final Country country;

  DetailPage(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flags?['png'] ?? country.flag, width: 200, height: 150),
            Text('Name: ${country.name}', style: TextStyle(fontSize: 20)),
            Text('Native Name: ${country.name}', style: TextStyle(fontSize: 16)), // Simplified, could expand with nativeName logic
            Text('Population: ${utils.formatPopulation(country.population)}', style: TextStyle(fontSize: 16)),
            Text('Area: ${country.area ?? 'N/A'} sq km', style: TextStyle(fontSize: 16)),
            Text('Region: ${country.region ?? 'N/A'}', style: TextStyle(fontSize: 16)),
            Text('Subregion: ${country.subregion ?? 'N/A'}', style: TextStyle(fontSize: 16)),
            Text('Time Zones: ${country.timezones?.join(', ') ?? 'N/A'}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}