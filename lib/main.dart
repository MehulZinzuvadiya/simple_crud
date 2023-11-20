import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'View/home_page.dart';
import 'View/read_data.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: [
      GetPage(
        name: '/',
        page: () => HomePage(),
      ),
      GetPage(
        name: '/read',
        page: () => ReadData(),
      ),
    ],
  ));
}
