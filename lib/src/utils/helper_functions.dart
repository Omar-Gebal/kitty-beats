String? extractVideoId(String youtubeLink) {
  RegExp regExp = RegExp(
      r"(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})");
  if (regExp.hasMatch(youtubeLink)) {
    Match? match = regExp.firstMatch(youtubeLink);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
  }
  return null;
}
