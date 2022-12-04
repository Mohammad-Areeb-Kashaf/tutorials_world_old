import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutorials_wallah/models/video_model.dart';
import 'package:tutorials_wallah/services/api_services.dart';
import 'package:tutorials_wallah/services/network_services.dart';
import 'package:tutorials_wallah/widget/my_snack-bar.dart';

class TutorialsServices {
  final _firestore = FirebaseFirestore.instance;
  void requestTutorial(BuildContext context, url, tutorialType) async {
    var uri = Uri.parse(url);
    var validUrl = uri.isAbsolute;
    if (validUrl) {
      if (tutorialType == "Playlist") {
        var playlistId = uri.queryParameters['list'].toString();
        addTutorial(playlistId, "Playlist");
        try {
          await _firestore
              .collection('Requested_playlists')
              .doc(playlistId)
              .set({'id': playlistId});
          showSnackBar(
              context, 'Your requested tutorial will be added in 24-48 hours',
              duration: 5);
        } catch (e) {
          showSnackBar(context, "There was an error");
        }
      }
    } else {
      var videoId = uri.queryParameters['v'];
      await _firestore
          .collection('Requested_videos')
          .doc(videoId)
          .set({'id': videoId});
      showSnackBar(
          context, 'Your requested tutorial will be added in 24-48 hours',
          duration: 5);
    }
  }

  void addTutorial(String id, String tutType) async {
    if (tutType == "Playlist") {
      try {
        var playlistVideos = [];
        var playlistDetails = await APIService.instance
            .fetchPlaylistWithPlaylistID(playlistId: id);
        var playlistTitle = playlistDetails[0].title;
        var playlistVideoCount = playlistDetails[0].videoCount;
        var playlistData = {
          "id": id,
          "title": playlistTitle,
        };
        await _firestore.collection("PlaylistIDs").doc(id).set(playlistData);
        for (int i = 0; i <= int.parse(playlistVideoCount); i += 8) {
          print(i);
          if (i == 0) {
          } else {
            APIService.nextPageToken = playlistVideos.last.nextPageToken;
          }
          List moreVideos =
              await APIService.instance.fetchVideosFromPlaylist(playlistId: id);
          List allVideos = playlistVideos..addAll(moreVideos);
          playlistVideos = allVideos;
        }

        for (int i = 0; i <= playlistVideos.length - 1; i++) {
          Video video = playlistVideos[i];
          var videoTitle = video.title;
          var videoId = video.id;
          var videoData = {
            'id': videoId,
            'title': videoTitle,
          };
          await _firestore.collection('VideosIDs').doc(videoId).set(videoData);
        }
      } catch (e) {
        print(e);
        NetworkStatusService().checkInternet();
      }
    }
  }
}
