import 'package:assessment/presentation/bloc/country_event.dart';
import 'package:assessment/presentation/pages/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';
import 'presentation/bloc/country_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Or configureDependencies() if you renamed it
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CountryBloc>()..add(LoadCountries()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Country App',
        theme: ThemeData(primarySwatch: Colors.blue),
        // Navigate to MainScreen first
        home: MainScreen(), 
      ),
    );
  }
}
