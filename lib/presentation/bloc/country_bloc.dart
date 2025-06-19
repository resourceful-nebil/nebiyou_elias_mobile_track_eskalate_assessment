import 'package:assessment/domain/entities/country.dart';
import 'package:assessment/domain/usecases/fetch_countries.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'country_event.dart';
import 'country_state.dart';

@injectable
class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final FetchCountries _fetchCountries;

  CountryBloc(this._fetchCountries) : super(CountryInitial()) {
    on<LoadCountries>(_onLoadCountries);
    on<SearchCountries>(_onSearchCountries);
    on<ToggleFavorite>(_onToggleFavorite);
    on<RefreshCountries>(_onRefreshCountries);
  }

  Future<void> _onLoadCountries(LoadCountries event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    try {
      final countries = await _fetchCountries();
      emit(CountryLoaded(countries));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }

  void _onSearchCountries(SearchCountries event, Emitter<CountryState> emit) {
    if (state is CountryLoaded) {
      final currentState = state as CountryLoaded;
      final filtered = currentState.countries
          .where((country) => country.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(CountryLoaded(filtered, isSearch: true));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<CountryState> emit) async {
    if (state is CountryLoaded) {
      final currentState = state as CountryLoaded;
      final updatedCountries = currentState.countries.map((country) {
        return country.name == event.country.name
            ? Country(
                name: country.name,
                population: country.population,
                flag: country.flag,
                area: country.area,
                region: country.region,
                subregion: country.subregion,
                timezones: country.timezones,
                isFavorite: !country.isFavorite,
              )
            : country;
      }).toList();
      await _saveFavorites(updatedCountries);
      emit(CountryLoaded(updatedCountries));
    }
  }

  Future<void> _onRefreshCountries(RefreshCountries event, Emitter<CountryState> emit) async {
    emit(CountryLoading());
    try {
      final countries = await _fetchCountries();
      emit(CountryLoaded(countries));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }

  Future<void> _saveFavorites(List<Country> countries) async {
    // This would typically be handled by a use case, but for simplicity, we'll call it here
    // In a real app, inject a SaveFavorites use case
  }
}