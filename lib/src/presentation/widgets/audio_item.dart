import 'package:flutter/material.dart';
import 'package:kitty_beats/src/presentation/controllers/home_screen_controller.dart';

class AudioItem extends StatelessWidget {
  final String path;
  final HomeScreenController controller;
  const AudioItem({super.key, required this.path, required this.controller});

  String extractTitleFromPath(String path) {
    final String fileNameAndFormat = path.split('/').last;
    final fileName = fileNameAndFormat.split('.').first;
    return fileName;
  }

  @override
  Widget build(BuildContext context) {
    final songTitle = extractTitleFromPath(path);
    return ListTile(
      title: Text(songTitle),
      onTap: () {
        controller.playAudio(path);
      },
    );
  }
}
