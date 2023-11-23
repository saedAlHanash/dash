import 'package:qareeb_dash/core/api_manager/api_url.dart';

String fixAvatarImage(String? image) {
  if (image == null || image.isEmpty) return '';
  if (image.startsWith('http')) return image;
  final String link = "https://$baseUrl/Images/$image";
  return link;
}

class FixUrl {
  String fixAvatarImage(String? image) {
    if (image == null) return '';
    if (image.startsWith('http')) return image;
    final String link = "https://$baseUrl/Images/$image";
    return link;
  }
}
