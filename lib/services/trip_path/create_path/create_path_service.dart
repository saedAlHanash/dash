import 'package:collection/collection.dart';
import 'package:qareeb_dash/core/strings/enum_manager.dart'; import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';
import 'package:qareeb_models/trip_path/data/models/trip_path.dart';

import '../../../core/api_manager/api_service.dart'; import 'package:qareeb_dash/core/strings/enum_manager.dart';

Future<int> createPath({required List<int> edgesIds}) async {
  await APIService().callApi(type: ApiType.post,
    url: PostUrl.createPath,
    body: {
      "name": "string",
      "arName": "string",
      "edgesIds": edgesIds.map((x) => x).toList(),
    },
  );

  var paths = await APIService().callApi(type: ApiType.get,
    url: 'api/services/app/PathService/GetPaths',
  );
  final json = paths.json['result'] ?? {};
  var list = List<TripPath>.from(json!.map((x) => TripPath.fromJson(x)));

  return list.lastOrNull?.id ?? 0;
}

