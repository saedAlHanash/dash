part of 'all_car_categories_cubit.dart';

class AllCarCategoriesInitial extends Equatable {
  final CubitStatuses statuses;
  final List<CarCategory> result;
  final String error;

  const AllCarCategoriesInitial({
    required this.statuses,
    required this.result,
    required this.error,
  });

  factory AllCarCategoriesInitial.initial() {
    return const AllCarCategoriesInitial(
      result: <CarCategory>[],
      error: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  AllCarCategoriesInitial copyWith({
    CubitStatuses? statuses,
    List<CarCategory>? result,
    String? error,
  }) {
    return AllCarCategoriesInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
    );
  }

}