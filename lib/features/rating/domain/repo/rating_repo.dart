import 'package:dartz/dartz.dart';
import 'package:qareeb_dash/features/rating/domain/entities/request/rating_request.dart';
import 'package:qareeb_dash/features/rating/domain/entities/response/rating_response.dart';

abstract class RatingRepo {
  Future<Either<String, RatingResponse>> ratingDriver(
      {required RatingRequest request});
}
