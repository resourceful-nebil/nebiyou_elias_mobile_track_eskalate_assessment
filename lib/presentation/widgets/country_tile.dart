import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_event.dart';
import '../bloc/country_state.dart';
import '../../domain/entities/country.dart';
import '../pages/detail_page.dart';
import '../../core/utils.dart' as utils;

class CountryTile extends StatelessWidget {
  final Country country;

  CountryTile({required this.country});

  @override
  Widget build(BuildContext context) {
    final imageUrl = country.flags?['png'] ?? 'https://via.placeholder.com/50x30'; // Fallback placeholder
    print('Loading image from: $imageUrl'); // Debug log
    return ListTile(
      leading: Image.network(
        imageUrl,
        width: 50,
        height: 30,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Image load error for $imageUrl: $error'); // Log error
          return Icon(Icons.error, color: Colors.red); // Show error icon
        },
      ),
      title: Text(country.name),
      subtitle: Text('Pop: ${utils.formatPopulation(country.population)}'),
      trailing: IconButton(
        icon: Icon(
          country.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: country.isFavorite ? Colors.red : null,
        ),
        onPressed: () => context.read<CountryBloc>().add(ToggleFavorite(country)),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(country)),
      ),
    );
  }
}