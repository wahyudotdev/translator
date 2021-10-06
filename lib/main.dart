import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/bindings/initial_bindings.dart';
import 'package:translator/feature/home/presentation/pages/chat_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: const ChatPage(),
      initialBinding: InitialBindings(),
    );
  }
}
