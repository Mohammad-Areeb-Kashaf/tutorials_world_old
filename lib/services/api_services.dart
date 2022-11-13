import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutorials_wallah/models/playlist_model.dart';
import 'package:tutorials_wallah/models/video_model.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/services/network_services.dart';

import '../screens/playlist_page.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  static String nextPageToken = '';
  static String maxResults = '8';

  Future<List<Playlist>> fetchPlaylistWithPlaylistID(
      {required String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails',
      'id': playlistId,
      'maxResults': maxResults,
      'pageToken': nextPageToken,
      'key': Constants.API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlists',
      parameters,
    );
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    //Get Playlist
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        PlaylistPageState.nextPageToken = data['nextPageToken'] ?? '';
        nextPageToken = data['nextPageToken'] ?? '';
        List<dynamic> playlistJson = data['items'];

        // Fetch first eight videos from uploads playlist
        List<Playlist> playlists = [];
        playlistJson.forEach(
          (json) => playlists.add(
            Playlist.fromMap(json),
          ),
        );
        return playlists;
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    } catch (e) {
      NetworkStatusService().checkInternet();
      throw e;
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist(
      {required String playlistId}) async {
    List<Video> videos = [];
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': maxResults,
      'pageToken': nextPageToken,
      'key': Constants.API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      'Accept': 'application/json',
    };

    // Get Playlist Videos
    try {
      var response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        nextPageToken = data['nextPageToken'] ?? '';
        List<dynamic> videosJson = data['items'];

        // Fetch first eight videos from uploads playlist

        videosJson.forEach(
          (json) => videos.add(
            Video.fromMap(json['snippet'], nextPageToken),
          ),
        );
        return videos;
      } else {
        throw json.decode(response.body)['error']['message'];
      }
    } catch (e) {
      NetworkStatusService().checkInternet();
      throw e;
    }
  }
}
