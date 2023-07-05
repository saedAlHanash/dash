class GetUrl {
  static const getPolicy = 'api/services/app/Settings/Getsettings';
  static const getSharedTrips =
      'api/services/app/SharedTripService/GetDriverFilteredTrips';

  static const getPreviousTrips = 'api/services/app/Order/GetDriverTrips';

  static const acceptor = 'api/services/app/Order/GetMyTripAccpter';
  static const tripById = 'api/services/app/Order/Get';

  static const getProfileInfo = 'api/services/app/UserService/Get';
  static const confirmTrip = 'api/services/app/Order/ConfirmTrip';
  static const cancelReason = 'api/services/app/CancelReasons/GetAll';

  static const getFavoritePlaces =
      'api/services/app/FavirotePlacesAppServices/GetFavirotePlacesByUser';

  static const getDriverLocation = 'api/services/app/UserService/GetDriversLocation';

  static const getAllPoints = 'api/services/app/PointsService/GetAll';

  static const getConnectedPoints = 'api/services/app/PointsService/GetConnectedPoints';

  static const getPointsEdge = 'api/services/app/EdgesService/GetEdgeBetweenTwoPoints';

  static const getSharedTripById = 'api/services/app/SharedTripService/GetSharedTripById';

  static const getPathById = 'api/services/app/PathService/GetPathById';

  static const driverAvailable = 'api/services/app/UserService/MakeDriverAavailable';

  static const driverUnAvailable = 'api/services/app/UserService/MakeDriverUnAavailable';

  static const currentTrip = 'api/services/app/UserService/GetCurrentOrder';

  static const getAvailableTrips = 'api/services/app/Order/GetAavailableTrips';

  static const getOldTrips = 'api/services/app/Order/GetDriverTrips';

  static var myWallet = 'api/services/app/AccountsService/GetAccountBalance';

  static var debt = 'api/services/app/AccountsService/DriverDebts';

  static var allDrivers ='api/services/app/User/GetAllDrivers';

  static var getDriverById = 'api/services/app/User/Get';
}

class PostUrl {
  static const requestOtp = 'api/Auth/RequestOTP';
  static const signup = 'api/services/app/Account/Register';
  static const acceptPolicy = 'api/services/app/AcceptPolicy/Create';

  static const ratingDriver = 'api/services/app/UserService/PostRate';
  static const addFavoritePlace = 'api/services/app/FavirotePlacesAppServices/Create';

  static const sendNote = 'api/services/app/Messages/CreateMessageForUser';
  static const confirmCode = 'api/Auth/VerifyAndLogin';
  static const forgotPassword = 'api/services/app/Account/ForgetPassword';
  static const resendCode = 'api/Auth/ResendOTP';
  static const resetPassword = 'api/services/app/Account/ResetNewPassword';
  static const checkTripInfo = 'api/services/app/Order/CheckTripInformation';
  static const cancelTrip = 'api/services/app/Order/CancelTrip';
  static const createTrip = 'api/services/app/Order/CreateTrip';
  static const addCoupon = 'api/services/app/Order/UseCouponTrip';
  static const createSharedTrip = 'api/services/app/SharedTripService/CreateSharedTrip';
  static const createPath = 'api/services/app/PathService/CreatePath';
  static const lookingForDriver = 'api/services/app/UserService/LookingForDriver';

  static const insertFireBaseToken =
      'api/services/app/UserService/InsertFireBaseTokenForUser';

  static const createPayment = 'api/services/app/Order/createTripPayment';
  static const mtnPaymentRequest = 'api/services/app/EpaymentService/MtnPaymentRequest';
  static const mtnSendOtp = 'api/services/app/EpaymentService/MtnDoPayment';

  static const rejectTrip = 'api/services/app/Order/RejectTrip';

  static const acceptTrip = 'api/services/app/Order/AcceptTrip';

  static const startTrip = 'api/services/app/Order/StartTrip';

  static const endTrip = 'api/services/app/Order/EndTrip';

  static var chargeClient = 'api/services/app/AccountsService/ChargeClientAccount';

  static var login = 'api/TokenAuth/Authenticate';

  static var getPermissions = 'api/services/app/Role/GetAllPermissions';
}

class PutUrl {
  static const updateProfile = 'api/services/app/User/UpdateUser';

  static const updateFavoritePlace = 'api/services/app/FavirotePlacesAppServices/Update';
  static var changeUserLocation = 'api/services/app/UserService/ChangeUserLocation';
}

class DeleteUrl {
  static const deleteFavoritePlace = 'api/services/app/FavirotePlacesAppServices/Delete';
}

class OrsUrl {
  static const getRoutePoints = 'v2/directions/driving-car';
  static const getLocationName = 'geocode/reverse';
  static const hostName = 'api.openrouteservice.org';
  static const key = '5b3ce3597851110001cf6248989ba286fa3c483496378107c01120f3';
}

class OsrmUrl {
  static const getRoutePoints = 'route/v1/driving';
  static const getLocationName =
      'reverse/?lat=33.50189625951751&lon=36.25612735748291&format=json';
  static const hostName = 'router.project-osrm.org';
  static const hostOsmName = 'nominatim.openstreetmap.org';
  static const key = '5b3ce3597851110001cf6248989ba286fa3c483496378107c01120f3';
}

class PathUrl {
  static const updateSharedTrip =
      'api/services/app/SharedTripService/UpdateSharedTripStatus';
}

const baseUrl = 'live.qareeb-maas.com';
