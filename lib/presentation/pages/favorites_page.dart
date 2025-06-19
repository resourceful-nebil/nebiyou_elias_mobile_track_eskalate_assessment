import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_state.dart';
import '../widgets/country_tile.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CountryError) {
            return Center(child: Text(state.message));
          }
          if (state is CountryLoaded) {
            final favorites = state.countries.where((c) => c.isFavorite).toList();
            return favorites.isEmpty
                ? const Center(child: Text('No favorite countries yet'))
                : ListView.builder(
                    itemCount: favorites.length,
                    itemBuilder: (context, index) =>
                        CountryTile(country: favorites[index]),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
