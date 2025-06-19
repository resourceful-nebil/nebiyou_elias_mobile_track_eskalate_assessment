import 'package:flutter/material.dart';
import '../../domain/entities/country.dart';
import '../../core/utils.dart' as utils;

class DetailPage extends StatelessWidget {
  final Country country;

  DetailPage(this.country);

  @override
  Widget build(BuildContext context) {
    final nativeName = country.nativeName?.values.first['common'] ?? country.name;
    final timezones = country.timezones ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Flag with flagpole effect
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.teal[100],
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    country.flags?['png'] ?? 'https://via.placeholder.com/200x150',
                    width: 300,
                    height: 150,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error, color: Colors.red),
                  ),
                  Positioned(
                    left: 20,
                    child: Container(
                      width: 2,
                      height: 150,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Key Statistics
            Text(
              'Key Statistics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            _buildStat('Area', '${country.area ?? 'N/A'} sq km'),
            _buildStat('Population', '${utils.formatPopulation(country.population)}'),
            _buildStat('Region', country.region ?? 'N/A'),
            _buildStat('Subregion', country.subregion ?? 'N/A'),
            // Timezone Buttons
            if (timezones.isNotEmpty) ...[
              SizedBox(height: 16),
              Text(
                'Timezone',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: timezones.map((tz) => ElevatedButton(
                  onPressed: () {}, // Placeholder, can add logic if needed
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: Text(tz),
                )).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}