import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/controller/homepage_controller.dart';
import 'package:to_do/core/constants/color_constnats.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String reason;
  int index = 0;

  TodoCard({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.reason,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    context.read<HomepageController>().imageList[index]),
                radius: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  Text(time),
                ],
              ),
              SizedBox(
                width: 150,
              ),
              Checkbox(
                value: true,
                onChanged: (value) {},
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: ColorConstnats.primaryBlack,
            height: .1,
            width: 400,
          )
        ],
      ),
    );
  }
}
