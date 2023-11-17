import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:stream/models/movie_detail_model.dart';
import 'package:stream/models/movie_model.dart';
import 'package:stream/models/serial_model.dart';

class MovieService {
  final dio = Dio();
  final baseUrl = 'https://api.themoviedb.org/3/';
  final token =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkMmEwZTM5MzcwZGVhN2Y5MTk5NWM2OWI2YjZkZWU0NSIsInN1YiI6IjY1NTM1YmRkNjdiNjEzNDVjYjRjZWZkYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.tEwvJLG_u-_3NCicepF1dn0sqyLUTnYW6oFvjk1-eQ8';
  Future<List<Movie>> getPopularMovies() async {
    try {
      final responses = await dio.get(
        '$baseUrl/discover/movie',
        queryParameters: {
          'include_adult': false,
          'include_video': false,
          'language': 'en-US',
          'page': 1,
          'sort_by': 'popularity.desc',
        },
        options: Options(
          headers: {
            'Authorization': token,
            'accept': 'application/json',
          },
        ),
      );
      if (responses.statusCode == 200) {
        return List<Movie>.from(
          responses.data['results'].map(
            (e) => Movie.fromJson(e),
          ),
        );
      } else {
        throw jsonDecode(responses.data['status_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> getMovies() async {
    try {
      final responses = await dio.get(
        '$baseUrl/discover/movie',
        queryParameters: {
          'include_adult': false,
          'include_video': false,
          'language': 'en-US',
          'page': 1,
          'sort_by': 'popularity.desc',
        },
        options: Options(
          headers: {
            'Authorization': token,
            'accept': 'application/json',
          },
        ),
      );
      if (responses.statusCode == 200) {
        return List<Movie>.from(
          responses.data['results'].map(
            (e) => Movie.fromJson(e),
          ),
        );
      } else {
        throw jsonDecode(responses.data['status_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Serial>> getSeries() async {
    try {
      final responses = await dio.get(
        '$baseUrl/discover/tv',
        queryParameters: {
          'include_adult': false,
          'include_video': false,
          'language': 'en-US',
          'page': 1,
          'sort_by': 'popularity.desc',
        },
        options: Options(
          headers: {
            'Authorization': token,
            'accept': 'application/json',
          },
        ),
      );
      if (responses.statusCode == 200) {
        return List<Serial>.from(
          responses.data['results'].map(
            (e) => Serial.fromJson(e),
          ),
        );
      } else {
        throw jsonDecode(responses.data['status_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieDetail> getMovieDetails(int id) async {
    try {
      final responses = await dio.get(
        '$baseUrl/movie/$id',
        queryParameters: {
          'language': 'en-US',
        },
        options: Options(
          headers: {
            'Authorization': token,
            'accept': 'application/json',
          },
        ),
      );
      if (responses.statusCode == 200) {
        return MovieDetail.fromJson(responses.data);
      } else {
        throw jsonDecode(responses.data['status_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Movie>> getSimilarMovies(int id) async {
    try {
      final responses = await dio.get(
        '$baseUrl/movie/$id/similar',
        queryParameters: {
          'language': 'en-US',
          'page': 1,
        },
        options: Options(
          headers: {
            'Authorization': token,
            'accept': 'application/json',
          },
        ),
      );
      if (responses.statusCode == 200) {
        return List<Movie>.from(
          responses.data['results'].map(
            (e) => Movie.fromJson(e),
          ),
        );
      } else {
        throw jsonDecode(responses.data['status_message']);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
