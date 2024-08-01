import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/controller/homepage_controller.dart';
import 'package:to_do/core/constants/color_constnats.dart';
import 'package:to_do/core/constants/image_constants.dart';
import 'package:to_do/view/bottom_navigation/bottom_navigation.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController title_controller = TextEditingController();
  TextEditingController date_controller = TextEditingController();
  TextEditingController time_controller = TextEditingController();
  TextEditingController note_controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstnats.backgroundColor,
        title: Text(
          "Add New Task",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: ColorConstnats.primarywhite),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Task Title",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller: title_controller,
                    decoration: InputDecoration(
                      labelText: "Task Title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please enter a title'
                          : null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.separated(
                            itemBuilder: (context, index) => CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(context
                                      .read<HomepageController>()
                                      .imageList[index]),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 20,
                                ),
                            itemCount: context
                                .read<HomepageController>()
                                .imageList
                                .length),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              onTap: () => _selectDate(context),
                              controller: date_controller,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Date",
                                suffixIcon: Icon(Icons.date_range_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (String? value) {},
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? 'Please select date'
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            TextFormField(
                              controller: time_controller,
                              readOnly: true,
                              onTap: () => _selectTime(context),
                              decoration: InputDecoration(
                                labelText: "Time",
                                suffixIcon: Icon(Icons.access_time_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (String? value) {},
                              validator: (String? value) {
                                return (value == null || value.isEmpty)
                                    ? 'Please select time'
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Notes",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: note_controller,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                      labelText: "Notes",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || value.isEmpty)
                          ? 'Please note'
                          : null;
                    },
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<HomepageController>().addNote(
                            title: title_controller.text,
                            date: date_controller.text,
                            time: time_controller.text,
                            reason: note_controller.text);

                        log("data added to hive");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigation(),
                            ));
                      }
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
                            "Save",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstnats.primarywhite),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024, 1),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        date_controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final now = DateTime.now();
      final dt =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final format = "${picked.hour}:${picked.minute}";
      setState(() {
        time_controller.text = format;
      });
    }
  }

  DateTime selectedDate = DateTime.now();
}
