import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:user_list_adapter_hive/screens/homescreen.dart';

import 'package:user_list_adapter_hive/screens/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
final Directory path = await getApplicationDocumentsDirectory();
Hive.init(path.path);
  Hive.registerAdapter(UserDetailsModelAdapter());
 var box = await Hive.openBox<UserDetailsModel>('user');
  //  await box.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
