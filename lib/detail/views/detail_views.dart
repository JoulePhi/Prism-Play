import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:stream/bloc/movies/movies_bloc.dart';
import 'package:stream/detail/views/genre_card.dart';
import 'package:stream/detail/views/related_movie.dart';
import 'package:stream/models/movie_model.dart';
import 'package:stream/shared/utils.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    context.read<MoviesBloc>().add(MovieGetDetails(movie.id!));
    return Scaffold(
      backgroundColor: bg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
            context.read<MoviesBloc>().add(MovieGetPopularMovie());
          },
        ),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MoviesFailed) {
            return flushbar(context, state.e);
          }

          if (state is MovieDetailSuccess) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .3,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500${state.movie.backdropPath.toString()}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: GlassmorphicContainer(
                      alignment: Alignment.center,
                      width: 64,
                      height: 64,
                      borderRadius: 50,
                      linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.1),
                            const Color(0xFFFFFFFF).withOpacity(0.05),
                          ],
                          stops: const [
                            0.1,
                            1,
                          ]),
                      border: 2,
                      blur: 2,
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.1),
                          const Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ],
                      ),
                      child: Image.asset(
                        'assets/icons/mini-play.png',
                        width: 24,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.movie.title.toString(),
                          style: whiteText.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/time.png',
                                  width: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${state.movie.runtime} Minutes',
                                  style: grayText.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/mini-star.png',
                                  width: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${state.movie.voteAverage!} (IMDb)',
                                  style: grayText.copyWith(fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Divider(color: gray, thickness: .1),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Release Date',
                                  style: whiteText.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  DateFormat('MMMM d, y')
                                      .format(state.movie.releaseDate!)
                                      .toString(),
                                  style: grayText.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Genre',
                                    style: whiteText.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: state.movie.genres!
                                          .map((e) => GenreCard(
                                              genre: e.name.toString()))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        const Divider(color: gray, thickness: .1),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          'Synopsis',
                          style: whiteText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ReadMoreText(
                          'Rey (Daisy Ridley) finally manages to find the legendary Jedi knight, Luke Skywalker (Mark Hamill) on an island with a magical aura. The heroes of The Force Awakens including Leia, Finn ',
                          trimLines: 3,
                          style: grayText,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Show more',
                          trimExpandedText: 'Show less',
                          moreStyle:
                              grayText.copyWith(fontWeight: FontWeight.bold),
                          lessStyle:
                              grayText.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Related Movies',
                          style: whiteText.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: state.movies
                                  .map((e) => RelatedMovie(movie: e))
                                  .toList()),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
