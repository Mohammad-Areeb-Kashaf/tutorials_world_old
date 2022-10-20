import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/models/playlist_model.dart';
import 'package:tutorials_wallah/models/video_model.dart';
import 'package:tutorials_wallah/services/api_services.dart';
import 'package:tutorials_wallah/widget/internet_checker.dart';
import 'package:tutorials_wallah/widget/playlist_tutorials_card.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentIndex = 0;
  List _playlistIDs = [];
  Map<String, List<Playlist>> _playlists = {};
  bool _isLoading = false;

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
      "PLzOt3noWLMtjI12lI5KA9pVGCtqmTBjj5"
    ];
    _playlists = {};
    for (int index = 0; index < _playlistIDs.length; index++) {
      print(index);
      var playlists = {
        _playlistIDs[index].toString(): await APIService.instance
            .fetchPlaylistWithPlaylistID(playlistId: _playlistIDs[index])
      };

      _playlists.addEntries(playlists.entries);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InternetChecker(
      child: Container(
        decoration: Constants.kBackground,
        child: Scaffold(
          body: _showScreen(),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 16.0,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.grey.shade500,
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Colors.deepPurple.shade800,
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
                backgroundColor: Colors.deepPurple.shade800,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
                backgroundColor: Colors.deepPurple.shade800,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Menu',
                backgroundColor: Colors.deepPurple.shade800,
              ),
            ],
            onTap: (value) {
              setState(() {
                _currentIndex = value;
              });
            },
          ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.shade600,
            centerTitle: true,
            title: _showTitle(),
          ),
        ),
      ),
    );
  }

  Widget _showScreen() {
    if (_currentIndex == 0) {
      return _playlists.isNotEmpty
          ? ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: int.parse(_playlists.length.toString()),
              itemBuilder: (context, index) {
                print("image !!!!");
                return PlaylistTutorialsCard(
                    playlistTitle: _playlists[_playlistIDs[index]]![0].title,
                    channelTitle:
                        _playlists[_playlistIDs[index]]![0].channelTitle,
                    videoCount: _playlists[_playlistIDs[index]]![0].videoCount,
                    onTap: () {},
                    playlistThumbnailUrl:
                        _playlists[_playlistIDs[index]]![0].thumbnailUrl);
              },
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
    } else if (_currentIndex == 1) {
      return Center(
        child: Text('Search Page'),
      );
    } else if (_currentIndex == 2) {
      return Center(
        child: Text('Account Page'),
      );
    } else if (_currentIndex == 3) {
      return Center(
        child: Text('Menu'),
      );
    } else {
      return Center(
        child: Text('Pata Nahi kounsa Page hai???'),
      );
    }
  }

  Widget _showTitle() {
    if (_currentIndex == 0) {
      return Text('Tutorials Wallah');
    } else if (_currentIndex == 1) {
      return Text('');
    } else if (_currentIndex == 2) {
      return Text('');
    } else if (_currentIndex == 3) {
      return Text('');
    } else {
      return Text('');
    }
  }
}
