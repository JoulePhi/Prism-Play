import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream/models/movie_detail_model.dart';
import 'package:stream/models/movie_model.dart';
import 'package:stream/models/serial_model.dart';
import 'package:stream/services/movie_services.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<MoviesEvent>((event, emit) async {
      if (event is MovieGetPopularMovie) {
        try {
          emit(MoviesLoading());
          final popularMovies = await MovieService().getPopularMovies();
          emit(MoviesSuccess(popularMovies));
        } catch (e) {
          emit(MoviesFailed(e.toString()));
        }
      }
      if (event is MovieGetMovies) {
        try {
          emit(MoviesLoading());
          final movies = await MovieService().getMovies();
          emit(MoviesSuccess(movies));
        } catch (e) {
          emit(MoviesFailed(e.toString()));
        }
      }
      if (event is MovieGetSeries) {
        try {
          emit(MoviesLoading());
          final movies = await MovieService().getSeries();
          emit(SeriesSuccess(movies));
        } catch (e) {
          emit(MoviesFailed(e.toString()));
        }
      }
      if (event is MovieGetDetails) {
        try {
          emit(MoviesLoading());
          final movie = await MovieService().getMovieDetails(event.id);
          final movies = await MovieService().getSimilarMovies(event.id);
          emit(MovieDetailSuccess(movie, movies));
        } catch (e) {
          emit(MoviesFailed(e.toString()));
        }
      }
    });
  }
}
