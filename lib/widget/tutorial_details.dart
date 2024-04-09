import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:tutorials_world/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialDetails extends StatelessWidget {
  final title;
  final desc;
  final videoCount;
  final creator;

  const TutorialDetails({
    super.key,
    required this.title,
    required this.desc,
    required this.videoCount,
    required this.creator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(
          width: 4.0,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Constants.kDarkBorderColor
              : Constants.kLightBorderColor,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    title,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          desc.toString().isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description: ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Linkify(
                        options: const LinkifyOptions(
                          defaultToHttps: true,
                        ),
                        text: desc,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        onOpen: (link) async {
                          if (await canLaunchUrl(
                              Uri.parse("${link.url.toString()}/"))) {
                            await launchUrl(
                                Uri.parse("${link.url.toString()}/"));
                          } else {}
                        },
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          videoCount.toString().isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Creator: ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  creator,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
