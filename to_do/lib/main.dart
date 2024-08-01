import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:to_do/controller/homepage_controller.dart';
import 'package:to_do/view/bottom_navigation/bottom_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HomepageController.initialize();
  runApp(ToDoList());
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomepageController(),
        )
      ],
      child: MaterialApp(
        // theme: ThemeData(scaffoldBackgroundColor: ColorConstnats.backgroundColor),
        debugShowCheckedModeBanner: false,
        home: BottomNavigation(),
      ),
    );
  }
}
