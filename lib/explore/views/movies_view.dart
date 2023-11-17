import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stream/bloc/movies/movies_bloc.dart';
import 'package:stream/detail/views/detail_views.dart';
import 'package:stream/models/movie_detail_model.dart';
import 'package:stream/shared/utils.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({super.key});

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is MoviesSuccess) {
          return MasonryGridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.movies.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => DetailView(
                        movie: state.movies[index],
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${state.movies[index].posterPath.toString()}',
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            // Image is fully loaded

                            return child;
                          } else {
                            // Image is still loading
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          }
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    RichText(
                      text: TextSpan(
                        text: state.movies[index].title.toString(),
                        style: whiteText.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                            text:
                                ' (${state.movies[index].releaseDate!.year.toString()}) ',
                            style: grayText.copyWith(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
