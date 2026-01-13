import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';

typedef WordTapCallback = void Function(String);

class WordSuggestionsSection extends StatelessWidget {
  static const animationDurationMillis = 250;

  final double height;
  final List<String> words;
  final WordTapCallback onWordTap;
  final scrollController = ScrollController();

  WordSuggestionsSection(
      {Key? key,
      required this.words,
      required this.onWordTap,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: words.length,
        itemBuilder: (context, int i) {
          var e = words[i];
          return InkWell(
            onTap: () {
              //Always return to start of suggestion list
              scrollController.animateTo(
                0,
                duration: Duration(milliseconds: animationDurationMillis),
                curve: Curves.linear,
              );
              onWordTap(e);
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: MongolText(
                  e,
                  style: TextStyle(fontFamily: 'z52agolatig', fontSize: 24),    //word suggestion font
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
