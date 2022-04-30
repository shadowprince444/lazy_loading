import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pixabay_pagination_example/controllers/internet_connectivity_controller.dart';
import 'package:pixabay_pagination_example/controllers/pagination_controller.dart';
import 'package:pixabay_pagination_example/view/screens/image_list_screen/pagination_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(InternetConnectivityController());
    Get.put(PaginationController());
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginatedScreen(),
    );
  }
}
