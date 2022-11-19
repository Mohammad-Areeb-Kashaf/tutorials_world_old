import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayer myYoutubePlayer(
    BuildContext context, controller, Function onReady) {
  return YoutubePlayer(
    controller: controller,
    showVideoProgressIndicator: true,
    progressColors: ProgressBarColors(
      backgroundColor: Colors.grey.shade600,
      playedColor: Colors.red,
      handleColor: Colors.red,
    ),
    onReady: onReady(),
    onEnded: (metadata) {
      Navigator.of(context).pop();
    },
  );
}
