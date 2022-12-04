class Video {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;
  final String nextPageToken;

  Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelTitle,
    required this.nextPageToken,
  });

  factory Video.fromMap(Map<String, dynamic> snippet, nextPageToken, isVideo) {
    return Video(
      id: isVideo ? snippet['id'] : snippet['resourceId']['videoId'],
      title: isVideo ? snippet['snippet']['title'] : snippet['title'],
      description:
          isVideo ? snippet['snippet']['description'] : snippet['description'],
      thumbnailUrl: isVideo
          ? snippet['snippet']['thumbnails']['high']['url']
          : snippet['thumbnails']['high']['url'],
      channelTitle: isVideo
          ? snippet['snippet']['channelTitle']
          : snippet['channelTitle'],
      nextPageToken: nextPageToken,
    );
  }
}
