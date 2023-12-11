import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String route;

  MenuItem(
    this.title,
    this.icon,
    this.route,
  );
}

final menuItems = <MenuItem>[
  MenuItem('Giroscopio', Icons.downloading, '/gyroscope'),
  MenuItem('Acelerómetro', Icons.speed, '/accelerometer'),
  MenuItem('Magnetometro', Icons.explore_outlined, '/magnetometer'),
  MenuItem(
      'Giroscopio Ball', Icons.sports_baseball_outlined, '/gyroscope-ball'),
  MenuItem('Compass', Icons.explore, '/compass'),
];

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: menuItems
          .map((item) => HomeMenuItem(
                title: item.title,
                icon: item.icon,
                route: item.route,
              ))
          .toList(),
    );
  }
}

class HomeMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  final List<Color> bgcolors;
  const HomeMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.route,
    this.bgcolors = const [Colors.lightBlue, Colors.blue],
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(route),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: bgcolors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }
}
