import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kitty_beats/src/presentation/controllers/home_screen_controller.dart';
import 'package:kitty_beats/src/presentation/mobx/home_screen_store.dart';
import 'package:kitty_beats/src/presentation/widgets/audio_item.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController controller;
  const HomeScreen({super.key}) : controller = const HomeScreenController();

  @override
  Widget build(BuildContext context) {
    final HomeScreenStore state = HomeScreenStore();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                    hintText: 'Youtube video url',
                    border: OutlineInputBorder()),
                onChanged: (value) => state.url = value,
              ),
              TextButton(
                onPressed: () {
                  controller.downloadAudio(state);
                },
                child: const Text('download audio'),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Test Button'),
              ),
              FutureBuilder(
                future: controller.returnDownloadedMusic(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<String> downloadedMusic = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: downloadedMusic.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AudioItem(
                          path: snapshot.data[index],
                          controller: controller,
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('error retrieving songs');
                  } else {
                    return Text('loading');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
