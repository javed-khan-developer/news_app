import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'controller/network_controller.dart';

void main() {
  Get.put(NetworkController());
  runApp(MyApp());
}
