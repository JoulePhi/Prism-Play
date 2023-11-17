import 'package:flutter/material.dart';
import 'package:stream/models/movie_model.dart';
import 'package:stream/shared/utils.dart';

class RelatedMovie extends StatelessWidget {
  const RelatedMovie({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    if (movie.backdropPath == null) {
      return Container();
    }

    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: movie.title.toString(),
              style: whiteText.copyWith(fontSize: 16),
              children: [
                TextSpan(
                  text: ' (${movie.releaseDate!.year}) ',
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
  }
}
