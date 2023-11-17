import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:stream/detail/views/detail_views.dart';
import 'package:stream/models/movie_model.dart';
import 'package:stream/shared/utils.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({super.key, required this.movies});
  final List<Movie> movies;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 400,
          aspectRatio: 9 / 16,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.4,
          scrollDirection: Axis.horizontal,
          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        ),
        items: movies.map((movie) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (c) => DetailView(
                        movie: movie,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath.toString()}',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          GlassmorphicContainer(
                            width: 80,
                            height: 50,
                            borderRadius: 15,
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
                            blur: 10,
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'IMDb',
                                    style: whiteText.copyWith(fontSize: 8),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/icons/Star.png',
                                        width: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: whiteText.copyWith(fontSize: 16),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GlassmorphicContainer(
                          width: double.infinity,
                          height: 80,
                          borderRadius: 20,
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
                          blur: 5,
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
                          child: Center(
                            child: Text(
                              movie.title.toString(),
                              style: whiteText.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
