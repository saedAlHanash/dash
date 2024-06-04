part of 'enrollments_cubit.dart';

class EnrollmentInitial extends AbstractCubit<List<Enrollment>> {
  // final EnrollmentRequest request;
  // final  bool enrollmentParam;
  const EnrollmentInitial({
    required super.result,
    super.error,
    // required this.request,
    // required this.enrollmentParam,
    super.statuses,
  });//

  factory EnrollmentInitial.initial() {
    return const EnrollmentInitial(
      result: [],
      error: '',
      // enrollmentParam: false,
      // request: EnrollmentRequest(),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];


  EnrollmentInitial copyWith({
    CubitStatuses? statuses,
    List<Enrollment>? result,
    String? error,
    // EnrollmentRequest? request,
    // bool? enrollmentParam,
  }) {
    return EnrollmentInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      // request: request ?? this.request,
      // enrollmentParam: enrollmentParam ?? this.enrollmentParam,
    );
  }
}
