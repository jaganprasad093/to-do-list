import 'package:flutter/material.dart';
import 'package:to_do/core/constants/color_constnats.dart';
import 'package:to_do/view/create_task/create_task.dart';
import 'package:to_do/view/done_page/done_page.dart';
import 'package:to_do/view/homepage/homepage.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  List screenList = [Homepage(), CreateTask(), DonePage()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screenList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          fixedColor: ColorConstnats.backgroundColor,
          unselectedItemColor: ColorConstnats.backgroundColor.withOpacity(.5),
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_rounded),
              label: 'Todo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check_box,
              ),
              label: 'done',
            ),
          ]),
    );
  }
}
