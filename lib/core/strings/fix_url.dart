String fixAvatarImage(String? image) {
  if (image == null || image.isEmpty) return '';
  if (image.startsWith('http')) return image;
  final String link = "https://live.qareeb-maas.com/Images/$image";
  return link;
}

class FixUrl {
  String fixAvatarImage(String? image) {
    if (image == null) return '';
    if (image.startsWith('http')) return image;
    final String link = "https://live.qareeb-maas.com/Images/$image";
    return link;
  }
}
