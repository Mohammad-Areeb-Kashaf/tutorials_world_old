import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';

import '../widget/decorated_button.dart';

class NoInternetPage extends StatelessWidget {
  NoInternetPage({super.key, required this.onTap});

  final onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: kBackgroundDecoration,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Internet Not Available',
                  style: TextStyle(color: Colors.white),
                ),
                DecoratedButton(
                  onTap: onTap,
                  child: Text('Retry'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
