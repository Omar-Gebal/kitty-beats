import 'dart:io';
import 'package:kitty_beats/src/presentation/mobx/home_screen_store.dart';
import 'package:kitty_beats/src/utils/helper_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreenController {
  const HomeScreenController();
  void playAudio() async {
    final player = AudioPlayer();
    var dataDirectory = await getExternalStorageDirectory();
    await for (var entity
        in dataDirectory!.list(recursive: true, followLinks: false)) {
      print(entity.path);
    }
    var songDirectory = '${dataDirectory!.path}/top.mp3';
    //print(songDirectory);
    await player.setAudioSource(AudioSource.file(songDirectory));
    //player.play();
  }

  void downloadAudio(HomeScreenStore state) async {
    //validates that the url is a valid youtube link
    if (extractVideoId(state.url) == null) {
      state.isValidUrl = false;
      return;
    }

    var youtube = YoutubeExplode();
    var video = await youtube.videos.get(state.url);
    var title = video.title;
    var manifest = await youtube.videos.streamsClient
        .getManifest(extractVideoId(state.url));
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    var audioUri = streamInfo.url;

    ///TODO: make this work for ios
    var directory = await getExternalStorageDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: audioUri.toString(),
      fileName: "$title.mp3",
      headers: {}, // optional: header send with url (auth token etc)
      savedDir: directory!.absolute.path,
      showNotification:
          true, // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    );

    youtube.close();
  }
}
