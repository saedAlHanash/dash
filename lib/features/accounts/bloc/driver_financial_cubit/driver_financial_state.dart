part of 'driver_financial_cubit.dart';

class DriverFinancialInitial extends Equatable {
  final CubitStatuses statuses;
  final DriverFinancialResult result;
  final String error;
  final FinancialFilterRequest request;

  const DriverFinancialInitial({
    required this.statuses,
    required this.result,
    required this.error,
    required this.request,
  });

  factory DriverFinancialInitial.initial() {
    return DriverFinancialInitial(
      result: DriverFinancialResult.fromJson({}),
      error: '',
      request: FinancialFilterRequest(),
      statuses: CubitStatuses.init,
    );
  }

  String get getMessage {
    switch (summaryType) {
      //السائق يجب أن يدفع للشركة
      case SummaryPayToEnum.requiredFromDriver:
        return 'يستوجب على السائق تسديد مبلغ للشركة وقدره   ';

      //الشركة يجب انت تدفع للسائق
      case SummaryPayToEnum.requiredFromCompany:
        return 'يستوجب على الشركة تسديد مبلغ للسائق وقدره  ';

      //الرصيد متكافئ
      case SummaryPayToEnum.equal:
        return 'ان مستحقات الشركة من السائق مساوية تماما لمستحقات السائق لدى الشركة';
    }
  }

  num get price {
    switch (summaryType) {
      //السائق يجب أن يدفع للشركة
      case SummaryPayToEnum.requiredFromDriver:
        return result.requiredAmountFromDriver - result.requiredAmountFromCompany;

      //الشركة يجب انت تدفع للسائق
      case SummaryPayToEnum.requiredFromCompany:
        return result.requiredAmountFromCompany - result.requiredAmountFromDriver;

      //الرصيد متكافئ
      case SummaryPayToEnum.equal:
        return 0;
    }
  }

  SummaryPayToEnum get summaryType {
    if (result.requiredAmountFromCompany > result.requiredAmountFromDriver) {
      return SummaryPayToEnum.requiredFromCompany;
    } else if (result.requiredAmountFromDriver > result.requiredAmountFromCompany) {
      return SummaryPayToEnum.requiredFromDriver;
    } else {
      return SummaryPayToEnum.equal;
    }
  }

  @override
  List<Object> get props => [statuses, result, error];

  DriverFinancialInitial copyWith({
    CubitStatuses? statuses,
    DriverFinancialResult? result,
    String? error,
    FinancialFilterRequest? request,
  }) {
    return DriverFinancialInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
