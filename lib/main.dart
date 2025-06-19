import 'package:assessment/presentation/pages/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';
import 'presentation/bloc/country_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); // Call the async init function
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CountryBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Country App',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        onGenerateRoute: (settings) {
          if (settings.name == '/') return MaterialPageRoute(builder: (_) => HomePage());
          if (settings.name == '/favorites') return MaterialPageRoute(builder: (_) => FavoritesPage());
          return null;
        },
      ),
    );
  }
}