import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialViewer extends StatefulWidget {
  final String id;
  final String title;
  const TutorialViewer({super.key, required this.id, required this.title});


  @override
  State<TutorialViewer> createState() => _TutorialViewerState();
}

class _TutorialViewerState extends State<TutorialViewer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        enableCaption: false,
        mute: false,
        autoPlay: false,
        forceHD: true,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Constants.kBackground,
        child:
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.deepPurple.shade600,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressColors: ProgressBarColors(
                      backgroundColor: Colors.grey.shade600,
                      playedColor: Colors.red,
                      handleColor: Colors.red,
                    ),
                    onReady: () {
                      print('Player is ready.');
                    },
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Title: ${widget.title}', style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
  @override
  void deactivate() {
    super.deactivate();
    _controller.pause();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
