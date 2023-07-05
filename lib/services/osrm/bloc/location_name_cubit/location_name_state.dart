part of 'location_name_cubit.dart';

class LocationNameInitial extends Equatable {
  final CubitStatuses statuses;
  final String startLocationName;
  final String endLocationName;
  final String error;
  final LatLng request;
  final bool isStart;

  const LocationNameInitial({
    required this.statuses,
    required this.request,
    required this.isStart,
    required this.startLocationName,
    required this.endLocationName,
    required this.error,
  });

  factory LocationNameInitial.initial() {
    return LocationNameInitial(
      startLocationName: '',
      endLocationName: '',
      error: '',
      isStart: false,
      statuses: CubitStatuses.init,
      request: LatLng(0, 0),
    );
  }

  @override
  List<Object> get props => [statuses, startLocationName, error, request];

  LocationNameInitial copyWith(
      {CubitStatuses? statuses,
      String? startLocationName,
      String? endLocationName,
      String? error,
      bool? isStart,
      LatLng? request}) {
    return LocationNameInitial(
      statuses: statuses ?? this.statuses,
      startLocationName: startLocationName ?? this.startLocationName,
      endLocationName: endLocationName ?? this.endLocationName,
      error: error ?? this.error,
      request: request ?? this.request,
      isStart: isStart ?? this.isStart,
    );
  }
}
