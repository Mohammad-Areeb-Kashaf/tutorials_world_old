import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tutorials_world/constants.dart';
import 'package:tutorials_world/models/video_model.dart';
import 'package:tutorials_world/screens/tutorial_viewer.dart';
import 'package:tutorials_world/services/api_services.dart';
import 'package:tutorials_world/services/network_services.dart';
import 'package:tutorials_world/widget/internet_checker.dart';
import 'package:tutorials_world/widget/tutorial_details.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({
    super.key,
    required this.playlistID,
    required this.title,
    required this.videoCount,
    required this.desc,
  });
  final playlistID;
  final title;
  final desc;
  final videoCount;

  @override
  State<PlaylistPage> createState() => PlaylistPageState();
}

class PlaylistPageState extends State<PlaylistPage> {
  bool _isLoading = false;
  static String nextPageToken = '';
  late List<Video> videos;

  @override
  void initState() {
    super.initState();
    try {
      videos = [];
      _getVideos();
    } catch (e) {
      videos = [];
    }
  }

  _getVideos() async {
    try {
      var result = await APIService.instance
          .fetchVideosFromPlaylist(playlistId: widget.playlistID);
      var allVideos = videos..addAll(result);
      setState(() {
        videos = allVideos;
      });
    } catch (e) {
      videos = [];
      NetworkStatusService().checkInternet();
    }
  }

  _loadMoreVideos() async {
    try {
      setState(() {
        _isLoading = true;
      });
      APIService.nextPageToken = videos.last.nextPageToken;
      List<Video> moreVideos = await APIService.instance
          .fetchVideosFromPlaylist(playlistId: widget.playlistID);
      List<Video> allVideos = videos..addAll(moreVideos);
      setState(() {
        videos = allVideos;
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      NetworkStatusService().checkInternet();
    }
  }

  _buildVideo(Video video, bool isWithDetail) {
    return Column(
      children: [
        isWithDetail
            ? TutorialDetails(
                title: video.title,
                desc: video.description,
                videoCount: widget.videoCount,
                creator: video.channelTitle,
              )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => TutorialViewer(
                    id: video.id,
                    desc: video.description,
                  ),
                ),
              ),
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4.0,
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Constants.kDarkBorderColor
                      : Constants.kLightBorderColor,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 180.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 4.0,
                          color: MediaQuery.of(context).platformBrightness ==
                                  Brightness.dark
                              ? Constants.kDarkBorderColor
                              : Constants.kLightBorderColor,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: video.thumbnailUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      video.title,
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        appBar: AppBar(
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.montserrat().fontFamily,
          ),
          title: videos.isNotEmpty
              ? SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? Colors.white
                          : Constants.purpleColor,
                    ),
                  ),
                )
              : const Text(''),
        ),
        body: videos.isNotEmpty
            ? NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollDetails) {
                  if (!_isLoading &&
                      videos.length != int.parse(widget.videoCount) &&
                      scrollDetails.metrics.pixels ==
                          scrollDetails.metrics.maxScrollExtent) {
                    _loadMoreVideos();
                  }
                  return false;
                },
                child: LoadingOverlay(
                  color: Colors.white,
                  opacity: 0.8,
                  progressIndicator: CircularProgressIndicator(
                    strokeWidth: 5.0,
                    valueColor: AlwaysStoppedAnimation<Color?>(
                        Theme.of(context).progressIndicatorTheme.color),
                  ),
                  isLoading: _isLoading,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        Video video = videos[index];
                        if (index == 0) {
                          return _buildVideo(video, true);
                        } else {
                          return _buildVideo(video, false);
                        }
                      },
                      physics: const BouncingScrollPhysics(),
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    APIService.nextPageToken = '';
  }
}
