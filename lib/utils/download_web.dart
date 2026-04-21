import 'dart:html' as html;

void downloadFile(String url) {
  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', '')
    ..click();
}