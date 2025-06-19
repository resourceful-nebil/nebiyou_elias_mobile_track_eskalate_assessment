import 'package:assessment/domain/entities/country.dart';
import 'package:equatable/equatable.dart';

abstract class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {}

class CountryLoading extends CountryState {}

class CountryLoaded extends CountryState {
  final List<Country> countries;
  final bool isSearch;

  const CountryLoaded(this.countries, {this.isSearch = false});

  @override
  List<Object?> get props => [countries, isSearch];
}

class CountryError extends CountryState {
  final String message;
  const CountryError(this.message);

  @override
  List<Object?> get props => [message];
}