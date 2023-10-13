// part of 'account_amount_cubit.dart';
//
// class AccountAmountInitial extends Equatable {
//   final CubitStatuses statuses;
//   final num driverAmount;
//   final num companyAmount;
//   final String error;
//   final int id;
//
//   const AccountAmountInitial({
//     required this.statuses,
//     required this.driverAmount,
//     required this.companyAmount,
//     required this.error,
//     required this.id,
//   });
//
//   factory AccountAmountInitial.initial() {
//     return const AccountAmountInitial(
//       driverAmount: 0,
//       companyAmount: 0,
//       error: '',
//       id: 0,
//       statuses: CubitStatuses.init,
//     );
//   }
//
//   String get getMessage {
//     switch (summaryType) {
//       //السائق يجب أن يدفع للشركة
//       case SummaryPayToEnum.requiredFromDriver:
//         return 'يستوجب على السائق تسديد مبلغ للشركة وقدره : ';
//
//       //الشركة يجب انت تدفع للسائق
//       case SummaryPayToEnum.requiredFromCompany:
//         return 'يستوجب على الشركة تسديد مبلغ للسائق وقدره : ';
//
//       //الرصيد متكافئ
//       case SummaryPayToEnum.equal:
//         return 'ان مستحقات الشركة من السائق مساوية تماما لمستحقات السائق لدى الشركة';
//     }
//   }
//
//   num get price {
//     switch (summaryType) {
//       //السائق يجب أن يدفع للشركة
//       case SummaryPayToEnum.requiredFromDriver:
//         return companyAmount - driverAmount;
//
//       //الشركة يجب انت تدفع للسائق
//       case SummaryPayToEnum.requiredFromCompany:
//         return driverAmount - companyAmount;
//
//       //الرصيد متكافئ
//       case SummaryPayToEnum.equal:
//         return 0;
//     }
//   }
//
//   SummaryPayToEnum get summaryType {
//     if (driverAmount > companyAmount) {
//       return SummaryPayToEnum.requiredFromCompany;
//     } else if (companyAmount > driverAmount) {
//       return SummaryPayToEnum.requiredFromDriver;
//     } else {
//       return SummaryPayToEnum.equal;
//     }
//   }
//
//   @override
//   List<Object> get props => [statuses, driverAmount, error];
//
//
//   AccountAmountInitial copyWith({
//     CubitStatuses? statuses,
//     num? driverAmount,
//     num? companyAmount,
//     String? error,
//     int? id,
//   }) {
//     return AccountAmountInitial(
//       statuses: statuses ?? this.statuses,
//       driverAmount: driverAmount ?? this.driverAmount,
//       companyAmount: companyAmount ?? this.companyAmount,
//       error: error ?? this.error,
//       id: id ?? this.id,
//     );
//   }
// }
