import 'package:http/http.dart';
import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:qareeb_dash/core/util/file_util.dart';

String fixAvatarImage(String? image) {
  if (image == null) return '';
  if (image.startsWith('http')) return image;
  final String link = "https://$baseUrl/Images/$image";
  return link;
}

Future<void> downloadFile(String url) async {
  if (url.isEmpty) return;
  final image = await fetchImage(url);
  await saveImageFile(name: 'image_fro_qareeb', pngBytes: image);
}
