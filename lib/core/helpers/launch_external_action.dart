import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalAction({
  required String scheme,
  required String path,
}) async {
  final uri = Uri(scheme: scheme, path: path);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $path');
  }
}
