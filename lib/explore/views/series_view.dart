import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stream/bloc/movies/movies_bloc.dart';
import 'package:stream/shared/utils.dart';

class SeriesView extends StatefulWidget {
  const SeriesView({super.key});

  @override
  State<SeriesView> createState() => _SeriesViewState();
}

class _SeriesViewState extends State<SeriesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SeriesSuccess) {
          return MasonryGridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.movies.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            itemBuilder: (context, index) {
              return Column(
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
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
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
                      text: state.movies[index].name.toString(),
                      style: whiteText.copyWith(fontSize: 16),
                    ),
                  )
                ],
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
