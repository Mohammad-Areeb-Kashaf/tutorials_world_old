import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';
import 'package:tutorials_wallah/widget/my_youtube_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 3.0,
                      color: Constants.purpleColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Title: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                title,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Expanded(
                              child: Linkify(
                                onOpen: (link) async {
                                  if (await canLaunchUrl(
                                      Uri.parse(link.url.toString()))) {
                                    print(link.url);
                                    await launchUrl(
                                        Uri.parse(link.url.toString()));
                                  } else {
                                    print('Could not launch $link');
                                  }
                                },
                                softWrap: true,
                                text: desc,
                                options: const LinkifyOptions(
                                  humanize: false,
                                ),
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Creator: ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              creator,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
