import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class RichTextFromHtmlLite extends StatelessWidget {
  final String html;
  final TextStyle? currentStyle;
  const RichTextFromHtmlLite(this.html, {super.key, this.currentStyle});

  @override
  Widget build(BuildContext context) {
    final RegExp tagExp = RegExp(r"<(\/?)(a|b|p)([^>]*)>");
    final List<InlineSpan> spans = [];
    final buffer = StringBuffer();
    TextStyle? currentStyle = this.currentStyle;
    currentStyle ??= TextStyle(
          color: AppColor.textGrey,
          fontSize: 13,
          height: 1.8,
          fontFamily: AppFont.font,
          fontWeight: FontWeight.w500,
      );

    String? currentHref;
    bool bold = false;

    void flushBuffer() {
      if (buffer.isEmpty) return;

      InlineSpan span;

      final style = currentStyle?.copyWith(
        fontWeight: bold ? FontWeight.bold : null,
        color: currentHref != null ? AppColor.blueLight : currentStyle.color,
      );

      if (currentHref != null) {
        span = TextSpan(
          text: buffer.toString(),
          style: style,
          recognizer: TapGestureRecognizer()..onTap=(){
            Navigator.pushNamed(context, '/${currentHref!}');
          },
        );
      } else {
        span = TextSpan(text: buffer.toString(), style: style);
      }

      spans.add(span);
      buffer.clear();
    }

    final tagMatches = tagExp.allMatches(html);
    int lastIndex = 0;

    for (final match in tagMatches) {
      final textSegment = html.substring(lastIndex, match.start);
      buffer.write(textSegment);
      flushBuffer();

      final isClosing = match.group(1) == "/";
      final tag = match.group(2);
      final attributes = match.group(3);

      if (tag == "a") {
        if (isClosing) {
          currentHref = null;
        } else {
          final RegExpMatch? hrefMatch = RegExp(r"href='([^']+)'").firstMatch(attributes??"");
          if (hrefMatch != null) {
            currentHref = hrefMatch.group(1);
          }
        }
      } else if (tag == "b") {
        bold = !isClosing;
      }else if (tag == "p") {
        if (!isClosing) {
          buffer.write(""); // Nada al abrir <p>
        } else {
          buffer.write("\n"); // Salto de párrafo al cerrar </p>
        }
      }

      lastIndex = match.end;
    }

    // Agregar texto restante
    buffer.write(html.substring(lastIndex));
    flushBuffer();

    return Text.rich(
      TextSpan(children: spans),
      textAlign: TextAlign.start,
    );
  }

}
