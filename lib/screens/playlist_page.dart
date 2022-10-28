import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    try {
      _getVideos();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent && videos.length <= int.parse(widget.videoCount) && videos.length != int.parse(widget.videoCount)) {
          print('${videos.length} != ${widget.videoCount}');
          print("Loading More Videos");
          _loadMoreVideos();
          print('Loaded Videos');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  _getVideos() async {
    try {
      videos = await APIService.instance.fetchVideosFromPlaylist(playlistId: widget.playlistID);
      setState(() {});
      print(videos);
    } catch (e) {
      print(e);
    }
  }

  _loadMoreVideos() async {
    List<Video> moreVideos =
    await APIService.instance.fetchVideosFromPlaylist(playlistId: widget.playlistID);
    List<Video> allVideos = videos..addAll(moreVideos);
    videos = allVideos;
    setState(() {
    });
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
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: 1 + videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == videos.length && videos.length <= int.parse(widget.videoCount) && videos.length != int.parse(widget.videoCount)) {
                      return Center(
                          child: Container(
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 30,
                        ),
                      ));
                    }
                    if (index <= int.parse(widget.videoCount) && index != int.parse(widget.videoCount)) {
                      Video video = videos[index];
                      return _buildVideo(video);
                    } else {
                      return SizedBox.shrink();
                    }

                  },
                  physics: BouncingScrollPhysics(),
                )
              : Center(
                  child: Container(
                    child: SpinKitCircle(
                      color: Colors.white,
                      size: 60,
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
    videos = [];
    APIService.nextPageToken = '';
  }
}
