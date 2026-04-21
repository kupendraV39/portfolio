import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio_3d/utils/download_helper.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> downloadResume(BuildContext context) async {
  const fileUrl =
      "https://docs.google.com/document/d/19gtRVYpM6RZ0fDX-6EO6vsiQpfEVO4Iw/export?format=pdf";

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("Downloading resume...")),
  );

  if (kIsWeb) {
    downloadFile(fileUrl);
  } else {
    final uri = Uri.parse(fileUrl);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
