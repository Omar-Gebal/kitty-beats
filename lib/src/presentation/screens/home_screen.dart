import 'package:flutter/material.dart';
import 'package:kitty_beats/src/presentation/controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller;
  const HomeScreen({super.key}) : controller = const HomeScreenController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TextField(),
          TextButton(
              onPressed: () {
                controller.downloadAudio();
              },
              child: Text('get audio'))
        ]),
      ),
    );
  }
}
