import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_world/models/playlist_model.dart';
import 'package:tutorials_world/models/video_model.dart';
import 'package:tutorials_world/screens/playlist_page.dart';
import 'package:tutorials_world/screens/request_tutorial.dart';
import 'package:tutorials_world/screens/sign_in_page.dart';
import 'package:tutorials_world/screens/tutorial_viewer.dart';
import 'package:tutorials_world/services/api_services.dart';
import 'package:tutorials_world/services/network_services.dart';
import 'package:tutorials_world/widget/internet_checker.dart';
import 'package:tutorials_world/widget/my_snack-bar.dart';
import 'package:tutorials_world/widget/tutorials_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  var _currentIndex = 0;
  List _playlistIDs = [];
  List _videosIDs = [];
  Map<String, List<Playlist>> _playlists = {};
  final Map<String, Video> _videos = {};

  @override
  void initState() {
    super.initState();
    try {
      getPlaylists();
    } catch (e) {
      throw e.toString();
    }
  }

  getPlaylists() async {
    _playlistIDs = [
      "PLu0W_9lII9agICnT8t4iYVSZ3eykIAOME",
      "PLu0W_9lII9ah7DDtYtflgwMwpT3xmjXY9",
      "PLu0W_9lII9ajLcqRcj4PoEihkukF_OTzA",
      "PLzOt3noWLMthRRVGsvhHaF0W_9Zif3ahQ",
      "PLzOt3noWLMthXqy_sRRzd15bptcGIKCF0",
      "PLzOt3noWLMthJKm8SJl2zmUlJiZp7fzo7",
      "PLzOt3noWLMtiX8unvZ_IryZDbD7qZ3nix",
      "PLzOt3noWLMtjI12lI5KA9pVGCtqmTBjj5",
    ];
    _videosIDs = [
      'ER9SspLe4Hg',
      'Q4p8vRQX8uY',
    ];
    _playlists = {};
    _playlistIDs.shuffle();
    try {
      Map<String, Video> videos = {};

      for (int index = 0; index < _videosIDs.length; index++) {
        videos = {
          _videosIDs[index].toString(): await APIService.instance
              .fetchVideoWithVideoID(videoId: _videosIDs[index])
        };
        _videos.addEntries(videos.entries);
        setState(() {});
      }
      Map<String, List<Playlist>> playlists = {};
      for (int index = 0; index < _playlistIDs.length; index++) {
        playlists = {
          _playlistIDs[index].toString(): await APIService.instance
              .fetchPlaylistWithPlaylistID(playlistId: _playlistIDs[index])
        };

        _playlists.addEntries(playlists.entries);
        setState(() {});
      }
    } catch (e) {
      NetworkStatusService().checkInternet();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _playlists = {};
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Scaffold(
        body: _showScreen(),
        bottomNavigationBar: _bottomNavigationBar(),
        appBar: _showAppBar(),
      ),
    );
  }

  _showAppBar() {
    if (_currentIndex == 0) {
      return AppBar(
        centerTitle: true,
        title: const Text('Tutorials Wallah'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      );
    } else if (_currentIndex == 1) {
      return AppBar(
        centerTitle: true,
        title: const Text('Tutorials Wallah'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
      );
    } else if (_currentIndex == 2) {
      return AppBar(
        centerTitle: true,
        title: const Text('Tutorials Wallah'),
      );
    } else if (_currentIndex == 3) {
      return AppBar(
        centerTitle: true,
        title: const Text('Tutorials Wallah'),
      );
    } else {
      return AppBar(
        centerTitle: true,
        title: const Text('Tutorials Wallah'),
      );
    }
  }

  Widget _videosPage() {
    return _videos.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _videos.length,
            itemBuilder: (context, index) {
              var videoIndex = _videos[_videosIDs[index].toString()];
              var title = videoIndex!.title;
              var desc = videoIndex.description;
              var channelTitle = videoIndex.channelTitle;
              return TutorialsCard(
                playlistThumbnailUrl: videoIndex.thumbnailUrl,
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => TutorialViewer(
                              id: _videosIDs[index], desc: desc)));
                },
                channelTitle: channelTitle,
                playlistTitle: title,
              );
            },
          )
        : const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
  }

  Widget _playlistsPage() {
    return _playlists.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _playlists.length,
            itemBuilder: (context, index) {
              var playlistIndex = _playlists[_playlistIDs[index]];
              var title = playlistIndex![0].title;
              var desc = playlistIndex[0].description;
              var channelTitle = playlistIndex[0].channelTitle;
              var videoCount = playlistIndex[0].videoCount;
              return TutorialsCard(
                  playlistTitle: title,
                  channelTitle: channelTitle,
                  videoCount: videoCount,
                  onTap: () {
                    APIService.nextPageToken = '';
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => PlaylistPage(
                          playlistID: _playlistIDs[index],
                          title: title,
                          desc: desc,
                          videoCount: videoCount,
                        ),
                      ),
                    );
                  },
                  playlistThumbnailUrl: playlistIndex[0].thumbnailUrl);
            },
          )
        : const Center(
            child: CircularProgressIndicator(
              strokeWidth: 5.0,
              valueColor: AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
  }

  Widget _accountPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            title: const Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              _auth.signOut();
              showSnackBar(context, "Sign Out Successful");
              Navigator.pushReplacement(context,
                  CupertinoPageRoute(builder: (context) => SignInPage()));
            },
          ),
        ],
      ),
    );
  }

  Widget _menuPage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => const RequestTutorial()));
            },
            title: const Text(
              'Request Tutorial',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showScreen() {
    if (_currentIndex == 0) {
      return _videosPage();
    } else if (_currentIndex == 1) {
      return _playlistsPage();
    } else if (_currentIndex == 2) {
      return _accountPage();
    } else {
      return _menuPage();
    }
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      selectedFontSize: 16.0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.play_arrow,
          ),
          label: 'Videos',
          activeIcon: Icon(
            CupertinoIcons.play_arrow_solid,
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(CupertinoIcons.square_list_fill),
          icon: Icon(CupertinoIcons.square_list),
          label: 'Playlists',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: 'Account',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.line_horizontal_3),
          label: 'Menu',
        ),
      ],
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
        setState(() {});
      },
    );
  }
}
