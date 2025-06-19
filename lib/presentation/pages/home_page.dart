import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../injection.dart';
import '../bloc/country_bloc.dart';
import '../bloc/country_event.dart';
import '../bloc/country_state.dart';
import '../widgets/country_tile.dart';

class HomePage extends StatelessWidget {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<CountryBloc>()..add(LoadCountries()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Countries'),
          centerTitle: true,
        ),
        body: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            if (state is CountryLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is CountryError) {
              return Center(child: Text(state.message));
            }
            if (state is CountryLoaded) {
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: () =>
                    context.read<CountryBloc>().add(RefreshCountries()),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: (query) => context
                            .read<CountryBloc>()
                            .add(SearchCountries(query)),
                        decoration: InputDecoration(
                          hintText: 'Search for a country',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Expanded(
                      child: state.countries.isEmpty && state.isSearch
                          ? Center(child: Text('No countries found'))
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
            return Container();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorites'),
          ],
          onTap: (index) {
            if (index == 1) Navigator.pushNamed(context, '/favorites');
          },
        ),
      ),
    );
  }
}
