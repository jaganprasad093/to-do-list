import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/controller/homepage_controller.dart';
import 'package:to_do/core/constants/color_constnats.dart';
import 'package:to_do/view/create_task/create_task.dart';
import 'package:to_do/view/widgets/todo_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    context.read<HomepageController>().getinikey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white.withOpacity(.9),
      appBar: AppBar(
        backgroundColor: ColorConstnats.backgroundColor,
        title: Text(
          "My Todo List",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstnats.primarywhite),
        ),
      ),
      body: HomepageController.notelistKeys.length == 0
          ? InkWell(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTask(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: ColorConstnats.backgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Add New Task",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: ColorConstnats.primarywhite),
                    ),
                  ),
                ),
              ),
            )
          : Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 500,
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        final currentKey =
                            HomepageController.notelistKeys[index];
                        final currentElement =
                            HomepageController.myBox.get(currentKey);
                        return TodoCard(
                          index: currentElement["index"] ?? 1,
                          title: currentElement["title"],
                          date: currentElement["date"],
                          reason: currentElement["reason"] ?? "no reason",
                          time: currentElement["time"],
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: HomepageController.notelistKeys.length),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
    );
  }
}
