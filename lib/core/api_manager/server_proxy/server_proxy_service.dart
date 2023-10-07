import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/core/api_manager/server_proxy/server_proxy_request.dart';
import 'package:qareeb_dash/core/extensions/extensions.dart';

import '../../error/error_manager.dart';
import '../../injection/injection_container.dart';
import '../../network/network_info.dart';
import '../../strings/app_string_manager.dart';
import '../../util/pair_class.dart';
import '../api_service.dart';

final network = sl<NetworkInfo>();

 Future<Pair<dynamic, String?>>  getServerProxyApi(
    {required ApiServerRequest request}) async {
  if (await network.isConnected) {
    final response =
        await APIService().postApi(url: PostUrl.serverProxy, body: request.toJson());

    if (response.statusCode == 200) {
      return Pair(response.json['result'], null);
    } else {
      return Pair(null, ErrorManager.getApiError(response));
    }
  } else {
    return Pair(null, AppStringManager.noInternet);
  }
}
