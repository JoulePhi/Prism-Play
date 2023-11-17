import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream/bloc/movies/movies_bloc.dart';
import 'package:stream/home/views/trending_movies.dart';
import 'package:stream/shared/utils.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            children: [
              Text(
                'Prism ',
                style: orangeText.copyWith(fontSize: 24),
              ),
              Text(
                'Play',
                style: whiteText.copyWith(fontSize: 24),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Container(
              margin: const EdgeInsets.only(top: 28),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage(
                    'assets/images/banner1.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constrain) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GlassmorphicContainer(
                        width: constrain.maxWidth * .75,
                        height: constrain.maxHeight * .4,
                        borderRadius: 20,
                        blur: 5,
                        alignment: Alignment.bottomCenter,
                        border: 2,
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
                            ]),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/icons/PlaySelected.png',
                                width: 28,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Continue Watching',
                                    style: grayText.copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Ready Player One',
                                    style: whiteText.copyWith(fontSize: 16),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            'Trending',
            style: whiteText.copyWith(fontSize: 24),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoading) {
              return const Expanded(
                  child: Center(
                child: CircularProgressIndicator(),
              ));
            }
            if (state is MoviesSuccess) {
              return TrendingMovies(movies: state.movies);
            }

            return Container();
          },
        )
      ],
    );
  }
}
