enum CubitStatuses { init, done, loading, error }

enum BookingPages { selectLocation, trip, booking }

enum StateScreen { non, confirmCode, policy, main, passwordCode }

enum NavTrip { waiting, have, accepted, started, ended }

enum MapType { normal, word, mix }

enum Gender { mail, female }

enum RedeemType { gold, oil, tire }

enum MtnState { init, pay, otp }

enum TripStatus { non, reject, accept, start, end }

enum MyMarkerType { location, driver, point, sharedPint, bus, tooltip }

enum SharedTripStatus { pending, started, closed, canceled }

enum SharedRequestStatus { pending, accepted, payed, pickedup, dropped, closed }

enum TransferType {
  sharedPay,
  tripPay,

  ///السائق دافع للشركة
  payoff,

  ///الشركة دافعة للسائق
  debit,
}

enum SummaryPayToEnum {
  ///السائق يجب أن يدفع للشركة
  requireDriverPay,

  ///الشركة يجب انت تدفع للسائق
  requireCompanyPay,

  ///الرصيد متكافئ
  equal,
}

enum TransferStatus { pending, closed }

enum TransferPayType { driverToCompany, companyToDriver }

enum Government { damascus, rifDimashq }

enum BusTripType { go, back }

enum BusTripCategory { qareebPoints, customPoints }

enum AttendanceType { up, down, unknown }

enum UserType { client, driver, admin, institutionAdmin }

enum WeekDays { sunday, monday, tuesday, wednesday, thursday, friday, saturday }

enum InstitutionType { school, college, transportation }
