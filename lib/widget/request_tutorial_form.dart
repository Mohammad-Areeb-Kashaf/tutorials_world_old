import 'package:flutter/material.dart';
import 'package:tutorials_wallah/constants.dart';
import 'package:tutorials_wallah/services/tutorials_services.dart';

import 'my_text_field.dart';

class RequestTutorialForm extends StatefulWidget {
  const RequestTutorialForm({super.key});

  @override
  State<RequestTutorialForm> createState() => _RequestTutorialFormState();
}

class _RequestTutorialFormState extends State<RequestTutorialForm> {
  final TextEditingController _tutUrlController = TextEditingController();
  String? _tutUrlErrorText;
  String? _tutorialType;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Constants.kDarkBorderColor
                        : Constants.kLightBorderColor,
                    width: 3.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: <Widget>[
                  MyTextField(
                    controller: _tutUrlController,
                    errorText: _tutUrlErrorText,
                    hintText: "Tutorial YouTube URL",
                    icon: Icons.person_outline,
                    isEmail: false,
                    isTutorial: true,
                    isFirstTutorial: true,
                  ),
                  DropdownButtonFormField(
                    dropdownColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    hint: const Text(
                      'Choose Tutorial Type',
                      style: TextStyle(color: Colors.black),
                    ),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 3.0),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 1,
                        child: Center(
                          child: Text(
                            'Playlist',
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Center(
                          child: Text(
                            'Video',
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == 1) {
                        _tutorialType = 'Playlist';
                      } else {
                        _tutorialType = 'Video';
                      }
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                var tutorialYouTubeUrl = _tutUrlController.text;
                TutorialsServices().requestTutorial(
                    context, tutorialYouTubeUrl, _tutorialType);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MediaQuery.of(context).platformBrightness ==
                          Brightness.dark
                      ? Theme.of(context).buttonTheme.colorScheme!.background
                      : Constants.purpleColor,
                ),
                child: const Center(
                  child: Text(
                    'Request Tutorial',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
