import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:just_audio/just_audio.dart';

class HomeScreenController {
  const HomeScreenController();
  void playAudio() async {
    final player = AudioPlayer();
    var dataDirectory = await getExternalStorageDirectory();
    var songDirectory = '${dataDirectory!.path}/top.mp3';
    print(songDirectory);
    await player.setAudioSource(AudioSource.file(songDirectory));
    player.play();
  }

  void downloadAudio() async {
    var youtube = YoutubeExplode();
    var video = await youtube.videos.get('https://youtu.be/pXRviuL6vMY');
    var title = video.title;
    var manifest =
        await youtube.videos.streamsClient.getManifest('pXRviuL6vMY');
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    var audioUri = streamInfo.url;
    print(audioUri.toString());

    ///TODO: make this work for ios
    var directory = await getExternalStorageDirectory();
    print(directory);
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
