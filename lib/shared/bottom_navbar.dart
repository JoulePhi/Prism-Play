import 'package:flutter/material.dart';
import 'package:stream/shared/routes.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedPage = 0;
              });
              AppRoute.mainRouteKey.currentState!.pushNamed('/');
            },
            child: selectedPage == 0
                ? Image.asset(
                    'assets/icons/HomeSelected.png',
                    width: 24,
                  )
                : Image.asset(
                    'assets/icons/Home.png',
                    width: 24,
                  ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedPage = 1;
              });
              AppRoute.mainRouteKey.currentState!.pushNamed('explore');
            },
            child: selectedPage == 1
                ? Image.asset(
                    'assets/icons/PlaySelected.png',
                    width: 24,
                  )
                : Image.asset(
                    'assets/icons/Play.png',
                    width: 24,
                  ),
          ),
          Image.asset(
            'assets/icons/Profile.png',
            width: 24,
          ),
        ],
      ),
    );
  }
}
