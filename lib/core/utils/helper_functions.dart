import 'package:url_launcher/url_launcher.dart' as launcher;

class HelperFunctions {
  HelperFunctions._();

  static Future<void> launchUrl(String url) async {
    print('Heperfuncions url ----- $url');
    final uri = Uri.parse(url);

  if (!await launcher.launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
}