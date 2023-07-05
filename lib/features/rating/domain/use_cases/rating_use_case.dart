import 'package:dartz/dartz.dart';
import 'package:qareeb_dash/features/rating/domain/entities/request/rating_request.dart';

import '../entities/response/rating_response.dart';
import '../repo/rating_repo.dart';

class RatingUseCase {
  RatingUseCase({required this.repository});

  final RatingRepo repository;

  Future<Either<String, RatingResponse>> call(
      {required RatingRequest request}) async {
    return await repository.ratingDriver(request: request);
  }
}
