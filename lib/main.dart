import 'package:dr_oh_app/app.dart';
import 'package:dr_oh_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'binding/init_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: InitBinding(),
      home: const App(),
    );
  }
}
