class Playlist {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoCount;
  final String channelTitle;

  Playlist({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoCount,
    required this.channelTitle,
  });

  factory Playlist.fromMap(
    Map<String, dynamic> items,
  ) {
    return Playlist(
      id: items['id'],
      title: items['snippet']['title'],
      thumbnailUrl: items['snippet']['thumbnails']['high']['url'],
      videoCount: items['contentDetails']['itemCount'].toString(),
      channelTitle: items['snippet']['channelTitle'],
    );
  }
}
