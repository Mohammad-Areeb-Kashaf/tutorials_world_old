import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/models/video_model.dart';
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
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  bool _isLoading = false;
  List<Video> videos = [];
  APIService api = APIService.instance;

  @override
  void initState() {
    super.initState();
    // try {
    getVideos();
    // } catch (e) {
    //   print(e);
    // }
  }

  getVideos() async {
    try {
      videos = await api.fetchVideosFromPlaylist(playlistId: widget.playlistID);
      print(videos);
      setState(() {});
    } catch (e) {}
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => {},
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
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
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

  // _loadMoreVideos() async {
  //   _isLoading = true;
  //   List<Video> moreVideos = await APIService.instance
  //       .fetchVideosFromPlaylist(playlistId: widget.playlistID);
  //   List<Video> allVideos = _channel.videos..addAll(moreVideos);
  //   setState(() {
  //     _channel.videos = allVideos;
  //   });
  //   _isLoading = false;
  // }

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
                      // _loadMoreVideos();
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (BuildContext context, int index) {
                      Video video = videos[index];
                      return _buildVideo(video);
                    },
                    physics: BouncingScrollPhysics(),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
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
}
