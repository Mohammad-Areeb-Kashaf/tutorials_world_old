import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/models/playlist_model.dart';
import 'package:tutorials_wallah/screens/playlist_page.dart';
import 'package:tutorials_wallah/screens/sign_in_page.dart';
import 'package:tutorials_wallah/services/api_services.dart';
import 'package:tutorials_wallah/services/network_services.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';
import 'package:tutorials_wallah/widget/my_snackbar.dart';
import 'package:tutorials_wallah/widget/playlist_tutorials_card.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  var _currentIndex = 0;
  List _playlistIDs = [];
  Map<String, List<Playlist>> _playlists = {};

  @override
  void initState() {
    super.initState();
    try {
      getPlaylists();
    } catch (e) {
      print(e);
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
    _playlists = {};
    _playlistIDs.shuffle();
    try {
      Map<String, List<Playlist>> playlists = {};
      for (int index = 0; index < _playlistIDs.length; index++) {
        print(index);
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
      );
    } else if (_currentIndex == 1) {
      return AppBar(
        centerTitle: true,
        title: const Text('Tutorials Wallah'),
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

  Widget _playlistsPage() {
    return _playlists.isNotEmpty
        ? ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _playlists.length,
            itemBuilder: (context, index) {
              var playlistIndex = _playlists[_playlistIDs[index]];
              var title = playlistIndex![0].title;
              var desc = playlistIndex![0].description;
              var channelTitle = playlistIndex[0].channelTitle;
              var videoCount = playlistIndex[0].videoCount;
              return PlaylistTutorialsCard(
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
                  playlistThumbnailUrl:
                      _playlists[_playlistIDs[index]]![0].thumbnailUrl);
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
        children: const [
          ListTile(
            title: Text(
              'Request a tutorial',
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
      return const Text('');
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
      unselectedItemColor: Colors.grey.shade500,
      selectedItemColor: Constants.purpleColor,
      currentIndex: _currentIndex,
      type: BottomNavigationBarType.shifting,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            CupertinoIcons.play_arrow,
          ),
          label: 'Videos',
          activeIcon: Icon(
            CupertinoIcons.play_arrow_solid,
            color: Constants.purpleColor,
          ),
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(CupertinoIcons.square_list_fill),
          icon: Icon(CupertinoIcons.square_list),
          label: 'Playlists',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          label: 'Account',
          backgroundColor: Colors.white,
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.line_horizontal_3),
          label: 'Menu',
          backgroundColor: Colors.white,
        ),
      ],
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
    );
  }
}
