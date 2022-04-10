import 'package:flutter/material.dart';

import '../View/homepage.dart';

class BottomNavBarFb5 extends StatelessWidget {
  BottomNavBarFb5({Key? key}) : super(key: key);

  final primaryColor = Color.fromARGB(255, 81, 81, 81);
  final secondaryColor = ThemeData.dark();
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: primaryColor,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBottomBar(
                  text: "Home",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  }),
              IconBottomBar(
                  text: "Search",
                  icon: Icons.search_outlined,
                  selected: false,
                  onPressed: () {}),
              IconBottomBar(
                  text: "Profile",
                  icon: Icons.person,
                  selected: false,
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {Key? key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed})
      : super(key: key);
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon:
              Icon(icon, size: 25, color: selected ? accentColor : Colors.grey),
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 12,
              height: .1,
              color: selected ? accentColor : Colors.grey),
        )
      ],
    );
  }
}
