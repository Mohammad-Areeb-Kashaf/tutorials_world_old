import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/models/video_model.dart';
import 'package:tutorials_wallah/screens/tutorial_viewer.dart';
import 'package:tutorials_wallah/services/api_services.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage(
      {super.key,
      required this.playlistID,
      required this.title,
      required this.videoCount});
  final playlistID;
  final title;
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
      print(e);
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
      print(videos);
    } catch (e) {
      videos = [];
      print(e);
    }
  }

  _loadMoreVideos() async {
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
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => TutorialViewer(id: video.id, title: video.title,)))
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 150.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: video.thumbnailUrl,
              width: 150.0,
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade600,
            title: videos.isNotEmpty ? Text(widget.title) : Text(''),
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
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.deepPurple.shade600,
                    ),
                  ),
                  isLoading: _isLoading,
                  child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (BuildContext context, int index) {
                        Video video = videos[index];
                        return _buildVideo(video);
                      },
                      physics: _isLoading
                          ? NeverScrollableScrollPhysics()
                          : BouncingScrollPhysics(),
                    ),
                ),
              )
              : Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
        ),
        decoration: Constants.kBackground,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    APIService.nextPageToken = '';
  }
}
