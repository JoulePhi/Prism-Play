import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:stream/bloc/movies/movies_bloc.dart';
import 'package:stream/explore/views/movies_view.dart';
import 'package:stream/explore/views/series_view.dart';
import 'package:stream/explore/views/tabbar_item.dart';
import 'package:stream/shared/utils.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  int selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            'Find Movies, Tv series, and more..',
            style: whiteText.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 20, bottom: 24),
            decoration: BoxDecoration(
                color: const Color(0xff211F30),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/Search.png',
                  width: 16,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search...',
                      hintStyle: hintText.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              length: 4,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      TabbarItem(
                        title: 'Movies',
                        id: 0,
                        selectedType: selectedType,
                      ),
                      TabbarItem(
                        title: 'Tv Series',
                        id: 1,
                        selectedType: selectedType,
                      ),
                      TabbarItem(
                        title: 'Documentary',
                        id: 2,
                        selectedType: selectedType,
                      ),
                      TabbarItem(
                        title: 'Sports',
                        id: 3,
                        selectedType: selectedType,
                      ),
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: const EdgeInsets.all(8),
                    indicatorWeight: 1.0,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    onTap: (id) {
                      if (id == 0) {
                        context.read<MoviesBloc>().add(MovieGetMovies());
                      } else if (id == 1) {
                        context.read<MoviesBloc>().add(MovieGetSeries());
                      }
                      setState(() {
                        selectedType = id;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        MoviesView(),
                        SeriesView(),
                        MoviesView(),
                        MoviesView(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
