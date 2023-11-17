import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream/app.dart';
import 'package:stream/bloc/movies/movies_bloc.dart';
import 'package:stream/home/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoviesBloc()..add(MovieGetPopularMovie()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppView(),
      ),
    );
  }
}
