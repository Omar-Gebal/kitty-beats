import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class HomeScreenController {
  const HomeScreenController();
  void downloadAudio() async {
    var youtube = YoutubeExplode();

    var video = await youtube.videos
        .get('https://youtu.be/pXRviuL6vMY?si=a1Af-GMzdvFydeqQ');
    var title = video.title;

    var manifest =
        await youtube.videos.streamsClient.getManifest('pXRviuL6vMY');
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    var audioUrl = streamInfo.url.toString();

    ///TODO: make this work for ios
    var directory = await getExternalStorageDirectory();

    final taskId = await FlutterDownloader.enqueue(
      url: audioUrl,
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
