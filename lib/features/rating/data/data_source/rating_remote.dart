import 'dart:convert';

import 'package:qareeb_dash/core/api_manager/api_service.dart';
import 'package:qareeb_dash/core/api_manager/api_url.dart';
import 'package:qareeb_dash/features/rating/domain/entities/request/rating_request.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/response/rating_response.dart';

abstract class RatingRemoteRepo {
  Future<RatingResponse> rateDriver({required RatingRequest request});
}

class RatingRemoteRepoImp implements RatingRemoteRepo {
 const RatingRemoteRepoImp();

  @override
  Future<RatingResponse> rateDriver({
    required RatingRequest request,
  }) async {

    final response = await APIService().postApi(
      url: PostUrl.ratingDriver,
      body: request.toJson(),
    );

    if (response.statusCode == 200) {
      return RatingResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException(response);
    }
  }
}
