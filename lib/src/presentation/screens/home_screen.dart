import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kitty_beats/src/presentation/controllers/home_screen_controller.dart';
import 'package:kitty_beats/src/presentation/mobx/home_screen_store.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller;
  const HomeScreen({super.key}) : controller = const HomeScreenController();

  @override
  Widget build(BuildContext context) {
    final HomeScreenStore state = HomeScreenStore();
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          TextField(
            onChanged: (value) => state.url = value,
          ),
          TextButton(
            onPressed: () {
              controller.downloadAudio(state);
            },
            child: Text('download audio'),
          ),
          TextButton(
            onPressed: () {
              controller.playAudio();
            },
            child: Text('play audio'),
          )
        ]),
      ),
    );
  }
}
