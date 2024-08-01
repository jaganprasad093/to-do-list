import 'package:flutter/material.dart';
import 'package:to_do/core/constants/color_constnats.dart';
import 'package:to_do/view/widgets/todo_card.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstnats.backgroundColor,
        title: Text(
          "Completed Task",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstnats.primarywhite),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: ListView.separated(
        //     itemBuilder: (context, index) => TodoCard(),
        //     separatorBuilder: (context, index) => SizedBox(
        //           height: 10,
        //         ),
        //     itemCount: 5),
      ),
    );
  }
}
