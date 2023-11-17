part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

class MovieGetPopularMovie extends MoviesEvent {}

class MovieGetMovies extends MoviesEvent {}

class MovieGetSeries extends MoviesEvent {}

class MovieGetDetails extends MoviesEvent {
  final int id;

  const MovieGetDetails(this.id);
}
