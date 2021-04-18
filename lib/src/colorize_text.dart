part of text_in_color;

class ColorizeText extends StatelessWidget {
  final Map<String, ColorizeTextAction> map;
  final Pattern pattern;
  final String text;
  final TextStyle textStyle;

  ColorizeText(this.map, this.text, {this.textStyle})
      : pattern = RegExp(
            map.keys.map((key) {
              return key;
            }).join('|'),
            multiLine: true);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: buildTextSpan(style: textStyle),
    );
  }

  TextSpan buildTextSpan({TextStyle style, bool withComposing}) {
    final List<InlineSpan> children = [];
    String patternMatched;
    String formatText;
    TextStyle myStyle;
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = map[match[0]]?.textStyle ??
            map[map.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text)
                  ..forEach((element) {
                    if (element.group(0) == match[0]) {
                      patternMatched = e;
                      ret = true;
                      return true;
                    }
                  });
                return ret;
              },
            )]
                .textStyle;

        Function(String) onPressed = map[match[0]]?.onPressed ??
            map[map.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text)
                  ..forEach((element) {
                    if (element.group(0) == match[0]) {
                      patternMatched = e;
                      ret = true;
                      return true;
                    }
                  });
                return ret;
              },
            )]
                .onPressed;

        switch (patternMatched) {
          case r"_(.*?)\_":
            formatText = match[0].replaceAll("_", " ");
            break;
          case r'\*(.*?)\*':
            formatText = match[0].replaceAll("*", " ");
            break;
          case "~(.*?)~":
            formatText = match[0].replaceAll("~", " ");
            break;
          case "r'```(.*?)```'":
            formatText = match[0].replaceAll("```", "   ");
            break;
          default:
            formatText = match[0];
            break;
        }

        children.add(TextSpan(
            text: formatText,
            style: style.merge(myStyle),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onPressed.call(map[match[0]]?.data ?? match[0]);
              }));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}
