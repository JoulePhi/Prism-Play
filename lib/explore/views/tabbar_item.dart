import 'package:flutter/material.dart';
import 'package:stream/shared/utils.dart';

class TabbarItem extends StatelessWidget {
  const TabbarItem({
    super.key,
    required this.title,
    required this.id,
    required this.selectedType,
  });
  final String title;
  final int id;
  final int selectedType;
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: selectedType == id
                    ? [
                        darkOrange,
                        lightOrange,
                      ]
                    : [
                        Colors.white,
                        Colors.white,
                      ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Text(
              title,
              style: orangeText.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          selectedType == id
              ? Container(
                  width: _textSize(title, orangeText.copyWith(fontSize: 16))
                          .width *
                      .5,
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    gradient: const LinearGradient(
                      colors: [
                        darkOrange,
                        lightOrange,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
