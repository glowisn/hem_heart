import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:gsheets/gsheets.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: GetBuilder<HomeController>(
          builder: (_){
          return Text(_.count.toString());
        },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          controller.sendInfo();
          
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
