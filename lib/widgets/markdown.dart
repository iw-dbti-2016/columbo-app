import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown/markdown.dart' as md;


class MarkDownText extends StatelessWidget {
  const MarkDownText(this.text, {this.key}): super(key: key);

  @override
  // ignore: overridden_fields
  final Key key;
  final String text;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      md.markdownToHtml(text, blockSyntaxes: [
        // TODO: Add inline tagging syntax
        SpotifySyntax()
      ]),
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      enableCaching: true,
      bodyPadding: const EdgeInsets.only(top: 5),
      webView: true,
      webViewJs: true,
      unsupportedWebViewWorkaroundForIssue37: true,
      key: Key('markdown-htmlwidget-$key'),
      onTapUrl: (String url) {
        print(url);
        // TODO Extract tag clicks
        // TODO Warn for external url's
      },
    );
  }
}


// No default is available to work with the attributes field
//  so this custom element is created.
class SpotifySyntax extends md.BlockSyntax {
  @override
  RegExp get pattern => RegExp(r'^spotify:track:([a-zA-Z0-9]+)$');

  @override
  md.Node parse(md.BlockParser parser) {
    final match = pattern.firstMatch(parser.current);
    parser.advance();

    return SpotifyElement('iframe', <String, String>{
      'src': 'https://open.spotify.com/embed/track/${match[1]}',
      'width': '300',
      'height': '64',
      'frameborder': '0',
      'allowtransparency': 'true',
      'allow': 'encrypted-media',
    });
  }
}

class SpotifyElement extends md.Element {
  SpotifyElement(String tag, this.attributes) : super(tag, null);

  @override
  // ignore: overridden_fields
  Map<String, String> attributes;

  @override
  bool get isEmpty => false;

  @override
  void accept(md.NodeVisitor visitor) {
    if (visitor.visitElementBefore(this)) {
      visitor.visitText(md.Text('spotify link')); // ->remove
      visitor.visitElementAfter(this);
    }
  }
}
