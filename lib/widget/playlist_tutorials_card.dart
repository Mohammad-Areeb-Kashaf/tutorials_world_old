import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';

class PlaylistTutorialsCard extends StatelessWidget {
  const PlaylistTutorialsCard({
    super.key,
    required this.playlistThumbnailUrl,
    required this.onTap,
    required this.videoCount,
    required this.channelTitle,
    required this.playlistTitle,
  });

  final String playlistThumbnailUrl;
  final String videoCount;
  final String channelTitle;
  final String playlistTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 3.0,
              color: Constants.purpleColor,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        width: 3.0,
                        color: Constants.purpleColor,
                      )),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        alignment: FractionalOffset.center,
                        imageUrl: playlistThumbnailUrl,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Row(
                  children: [
                    const Text(
                      'Title: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        playlistTitle,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Row(
                  children: [
                    const Text(
                      'Video Count: ',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      videoCount,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Creator: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          channelTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final Function() onTap;
}
