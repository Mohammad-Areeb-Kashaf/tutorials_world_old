import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tutorials_world/constants.dart';

class TutorialsCard extends StatelessWidget {
  const TutorialsCard({
    super.key,
    required this.playlistThumbnailUrl,
    required this.onTap,
    this.videoCount = '',
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
            color: ThemeData.dark().appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              width: 4.0,
              color:
                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? Constants.kDarkBorderColor
                      : Constants.kLightBorderColor,
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
                      width: 4.0,
                      color: MediaQuery.of(context).platformBrightness ==
                              Brightness.dark
                          ? Constants.kDarkBorderColor
                          : Constants.kLightBorderColor,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
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
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Row(
                  children: [
                    const Text(
                      'Title: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        playlistTitle,
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              videoCount.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 12.0),
                      child: Row(
                        children: [
                          const Text(
                            'Video Count: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            videoCount,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                child: Row(
                  children: [
                    const Text(
                      'Creator: ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      channelTitle,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
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
