part of 'movies_bloc.dart';

sealed class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

final class MoviesInitial extends MoviesState {}

final class MoviesLoading extends MoviesState {}

final class MoviesSimilarLoading extends MoviesState {}

final class MoviesFailed extends MoviesState {
  final String e;
  const MoviesFailed(this.e);

  @override
  List<Object> get props => [e];
}

final class MoviesSuccess extends MoviesState {
  final List<Movie> movies;

  const MoviesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

final class SeriesSuccess extends MoviesState {
  final List<Serial> movies;

  const SeriesSuccess(this.movies);

  @override
  List<Object> get props => [movies];
}

final class MovieDetailSuccess extends MoviesState {
  final MovieDetail movie;
  final List<Movie> movies;

  const MovieDetailSuccess(this.movie, this.movies);

  @override
  List<Object> get props => [movie, movies];
}
