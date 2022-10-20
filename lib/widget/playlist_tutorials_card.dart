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
  Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap(),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 217,
                width: 387,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 1),
                      blurRadius: 6.0,
                    )
                  ],
                  image: DecorationImage(
                      alignment: FractionalOffset.center,
                      image: NetworkImage(playlistThumbnailUrl),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      'Source: YouTube',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height.round() - 503,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
