import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilityService {

  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red
      ),
    );
  }
  static Future<void> launch(String? url) async {
    if ( url == null || url.isEmpty) {
      return;
    }
    var uri = Uri.tryParse(url!)!;
    if (uri.scheme.isEmpty) {
      uri = Uri.parse('https://$url');
    }

    await launchUrl(uri);
  }
}
