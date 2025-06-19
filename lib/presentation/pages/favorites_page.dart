import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_event.dart';
import '../bloc/country_state.dart';
import '../widgets/country_tile.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CountryBloc>()..add(LoadCountries()), // Force reload to reflect favorites
      child: Scaffold(
        appBar: AppBar(title: Text('Favorites')),
        body: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CountryError) {
              return Center(child: Text(state.message));
            }
            if (state is CountryLoaded) {
              final favorites = state.countries.where((country) => country.isFavorite).toList();
              return favorites.isEmpty
                  ? Center(child: Text('No favorite countries yet'))
                  : ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (context, index) => CountryTile(country: favorites[index]),
                    );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}