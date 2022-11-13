import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlaylistTutorialsCard extends StatelessWidget {
  PlaylistTutorialsCard({
    required this.playlistThumbnailUrl,
    required this.onTap,
    required this.videoCount,
    required this.channelTitle,
    required this.playlistTitle,
  });

  final playlistThumbnailUrl;
  final String videoCount;
  final String channelTitle;
  final String playlistTitle;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      alignment: FractionalOffset.center,
                      imageUrl: playlistThumbnailUrl,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 6.0),
                  child: Row(
                    children: [
                      Text(
                        'Title: ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          playlistTitle,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
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
                    children: [
                      Text(
                        'Video Count: ',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        videoCount,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 6.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Creator: ',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            channelTitle,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
