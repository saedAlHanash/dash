import 'package:dartz/dartz.dart';
import 'package:qareeb_dash/core/strings/app_string_manager.dart';
import 'package:qareeb_dash/features/rating/domain/entities/response/rating_response.dart';

import '../../../../core/error/error_manager.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/request/rating_request.dart';
import '../../domain/repo/rating_repo.dart';
import '../data_source/rating_remote.dart';

class RatingRepoImp implements RatingRepo {
  final RatingRemoteRepo remote;
  final NetworkInfo network;

  RatingRepoImp({
    required this.remote,
    required this.network,
  });

  @override
  Future<Either<String, RatingResponse>> ratingDriver(
      {required RatingRequest request}) async {
    if (await network.isConnected) {
      try {
        final remotePosts = await remote.rateDriver(request: request);

        return Right(remotePosts);
      } on ServerException catch (response) {
        return Left(ErrorManager.getApiError(response.errorBody));
      }
    } else {
      return const Left(AppStringManager.noInternet);
    }
  }
}
