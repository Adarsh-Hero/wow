import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:istreamo/model/owner.dart';
import 'package:istreamo/model/userRepo.dart';
import 'package:istreamo/repo/network_call.dart';
import 'package:istreamo/screens/auth.dart';
import 'package:istreamo/screens/users_list.dart';

import 'bloc/user_bloc.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'client/hive_names.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserRepoAdapter());
  Hive.registerAdapter(OwnerAdapter());
  await Hive.openBox<UserRepo>(HiveBoxes.userRepo);
  await Hive.openBox<UserRepo>(HiveBoxes.owner);
  runApp(const MyAppHome());
}

class MyAppHome extends StatelessWidget {
  const MyAppHome({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyApp());
  }
}

