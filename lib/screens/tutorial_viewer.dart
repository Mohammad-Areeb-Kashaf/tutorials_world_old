import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';
import 'package:tutorials_wallah/widget/my_youtube_player.dart';
import 'package:tutorials_wallah/widget/tutorial_details.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialViewer extends StatefulWidget {
  final String id;
  final String desc;
  const TutorialViewer({super.key, required this.id, required this.desc});

  @override
  State<TutorialViewer> createState() => _TutorialViewerState();
}

class _TutorialViewerState extends State<TutorialViewer> {
  late YoutubePlayerController _controller;
  String title = '';
  String desc = '';
  String creator = '';

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(
        enableCaption: false,
        mute: false,
        autoPlay: true,
        forceHD: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    title = _controller.metadata.title;
    creator = _controller.metadata.author;
    return YoutubePlayerBuilder(
      player: myYoutubePlayer(
        context,
        _controller,
        () {
          Future.delayed(Duration.zero, () {
            setState(() {
              desc = widget.desc;
            });
          });
        },
      ),
      builder: (context, player) => InternetChecker(
        child: Scaffold(
          appBar: AppBar(
            title: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Text(
                _controller.metadata.title,
                style: TextStyle(
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          body: ListView(
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TutorialDetails(
                  title: title,
                  desc: desc,
                  videoCount: "",
                  creator: creator,
                ),
              ),
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
