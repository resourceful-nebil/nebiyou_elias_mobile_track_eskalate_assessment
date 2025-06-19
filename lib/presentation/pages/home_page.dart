import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_event.dart';
import '../bloc/country_state.dart';
import '../widgets/country_tile.dart';

class HomePage extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
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
            return SmartRefresher(
              controller: _refreshController,
              onRefresh: () {
                context.read<CountryBloc>().add(RefreshCountries());
                _refreshController.refreshCompleted();
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (query) => context
                          .read<CountryBloc>()
                          .add(SearchCountries(query)),
                      decoration: const InputDecoration(
                        hintText: 'Search for a country',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  Expanded(
                    child: state.countries.isEmpty && state.isSearch
                        ? const Center(child: Text('No countries found'))
                        : ListView.builder(
                            itemCount: state.countries.length,
                            itemBuilder: (context, index) =>
                                CountryTile(country: state.countries[index]),
                          ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
