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
  static const getSharedTripByRequestId =
      'api/services/app/SharedTripService/GetSharedTripByRequestId';

  static const getPathById = 'api/services/app/PathService/GetPathById';

  static const driverAvailable = 'api/services/app/UserService/MakeDriverAavailable';

  static const driverUnAvailable = 'api/services/app/UserService/MakeDriverUnAavailable';

  static const currentTrip = 'api/services/app/UserService/GetCurrentOrder';

  static const getAvailableTrips = 'api/services/app/Order/GetAavailableTrips';

  static const getOldTrips = 'api/services/app/Order/GetDriverTrips';

  static const myWallet = 'api/services/app/AccountsService/GetAccountBalance';

  static const debt = 'api/services/app/AccountsService/DriverDebts';

  static const allDrivers = 'api/services/app/User/GetAllDrivers';

  static const getDriverById = 'api/services/app/User/GetDriverById';

  static const driverRedeems = 'api/services/app/RedeemService/GetRedeems';
  static const allRedeems = 'api/services/app/RedeemService/GetAllRedeems';

  static const carCategories = 'api/services/app/CarCategoriesService/GetAll';

  static const bestDriver = 'api/services/app/User/GetBestDriver';
  static const getAllAdmins = 'api/services/app/User/getAllAdmins';

  static const allRoles = 'api/services/app/Role/GetAll';

  static const getAllClients = 'api/services/app/User/GetAllCustomars';

  static const getClientById = 'api/services/app/User/Get';
  static const pointById = 'api/services/app/PointsService/Get';

  static const getAllEdgesPoint = 'api/services/app/EdgesService/GetEdgesFromPoint';

  static const getAllEpay = 'api/services/app/EpaymentService/GetAll';

  static const getAllMessages = 'api/services/app/Messages/GetAll';

  static const getAllTransfers = 'api/services/app/AccountsService/GetAllTransfers';

  static const getAllTrips = 'api/services/app/Order/GetAllTrips';

  static const getAllSharedTrips = 'api/services/app/SharedTripService/GetAllSharedTrips';

  static const fromDriver = 'api/services/app/AccountsService/RequiredAmountFromDriver';

  static const fromCompany = 'api/services/app/AccountsService/DriverDebtFromCompany';

  static const getAllCoupons = 'api/services/app/Coupons/GetAll';

  static const allPermissions = 'api/services/app/Role/GetAllPermissions';

  static const institutions = 'api/services/app/InstitutiosnsService/GetAll';

  static const systemParams = 'api/services/app/SystemParametersService/GetAll';

  static const systemSettings = 'api/services/app/SystemSettingsService/GetAll';

  static const financialReport = 'api/services/app/AccountsService/FinancialReport';

  static const tempTrips = 'api/services/app/PathService/GetPaths';

  static const tempTripById = 'api/services/app/PathService/GetPathById';

  static const governments = 'api/services/app/GovernorateService/GetAll';
  static const areas = 'api/services/app/AreaService/GetAll';
}

class PostUrl {
  static const serverProxy = 'api/services/app/HttpRequestService/ExecuteRequest';
  static const requestOtp = 'api/Auth/RequestOTP';
  static const sendNotificaion =
      'api/services/app/SystemNotificationService/ProdcastNotification';
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

  static const chargeClient = 'api/services/app/AccountsService/ChargeClientAccount';

  static const login = 'api/TokenAuth/Authenticate';

  static const getPermissions = 'api/services/app/Role/GetUserPermissions';

  static const createRedeem = 'api/services/app/RedeemService/CreateRedeem';

  static const createDriver = 'api/services/app/User/CreateDriver';

  static const activateUser = "api/services/app/User/Activate";

  static const deactivateUser = "api/services/app/User/DeActivate";

  static const createReason = 'api/services/app/CancelReasons/Create';

  static const createCarCategory = 'api/services/app/CarCategoriesService/Create';

  static const createAdmin = 'api/services/app/User/Create';

  static const createPoint = 'api/services/app/PointsService/CreatePoint';

  static const createEdge = 'api/services/app/EdgesService/CreateEdge';

  static const createPolicy = 'api/services/app/Settings/Updatesettings';

  static const createFromDriver = 'api/services/app/PaymentService/CreatePayOffPayment';
  static const createFromCompany = 'api/services/app/PaymentService/CreateDebtPayment';
  static const createCoupon = 'api/services/app/Coupons/Create';

  static const createRole = 'api/services/app/Role/Create';

  static const createInstitution = 'api/services/app/InstitutiosnsService/Create';
  static const createTempTrip = 'api/services/app/PathService/CreatePath';

  static const estimateSharedTrip = 'api/services/app/PathService/GetPathEstimation';
  static const createGovernment = 'api/services/app/GovernorateService/Create';
  static const createArea = 'api/services/app/AreaService/Create';
}

class PutUrl {
  static const updateGovernment = 'api/services/app/GovernorateService/Update';
  static const updateArea = 'api/services/app/AreaService/Update';
  static const updateProfile = 'api/services/app/User/UpdateUser';
  static const updateDriver = 'api/services/app/User/UpdateDriver';

  static const updateFavoritePlace = 'api/services/app/FavirotePlacesAppServices/Update';
  static const changeUserLocation = 'api/services/app/UserService/ChangeUserLocation';

  static const updateCarCategory = 'api/services/app/CarCategoriesService/Update';

  static const updateAdmin = 'api/services/app/User/Update';

  static const updatePoint = 'api/services/app/PointsService/Update';

  static const updateEdge = 'api/services/app/EdgesService/Update';
  static const updateCoupon = 'api/services/app/Coupons/Update';
  static const updateRole = 'api/services/app/Role/Update';

  static const updateInstitution = 'api/services/app/InstitutiosnsService/Update';

  static const updateParams = 'api/services/app/SystemParametersService/Update';

  static const updateSetting = 'api/services/app/SystemSettingsService/Update';

  static const updateTempTrip = 'api/services/app/PathService/UpdatePath';
}

class DeleteUrl {
  static const deleteTempTrip = 'api/services/app/PathService/DeletePath';
  static const deleteFavoritePlace = 'api/services/app/FavirotePlacesAppServices/Delete';

  static const deleteCancelReason = 'api/services/app/CancelReasons/Delete';
  static const deleteCarCategory = 'api/services/app/CarCategoriesService/Delete';

  static const deleteEdge = 'api/services/app/EdgesService/RemoveEdge';

  static const deletePoint = 'api/services/app/PointsService/Delete';

  static const deleteRole = 'api/services/app/Role/Delete';

  static const deleteInstitution = 'api/services/app/InstitutiosnsService/Delete';

  static var deleteCancelGovernment = 'api/services/app/GovernorateService/Delete';
  static var deleteCancelArea = 'api/services/app/AreaService/Delete';
}

class OrsUrl {
  static const getRoutePoints = 'v2/directions/driving-car';
  static const getLocationName = 'geocode/reverse';
  static const hostName = 'api.openrouteservice.org';
  static const key = '5b3ce3597851110001cf6248989ba286fa3c483496378107c01120f3';
}

class OsrmUrl {
  static const getRoutePoints = 'route/v1/driving';
  static const getLocationName = 'reverse';
  static const hostName = 'router.project-osrm.org';
  static const hostOsmName = 'nominatim.openstreetmap.org';
  static const key = '5b3ce3597851110001cf6248989ba286fa3c483496378107c01120f3';
}

class PathUrl {
  static const updateSharedTrip =
      'api/services/app/SharedTripService/UpdateSharedTripStatus';

  static const changeLoyalty = 'api/services/app/UserService/ChangeSubscriptionInLoyalty';

  static const changeProviderState =
      'api/services/app/EpaymentService/ChangeActiveStatus';
}

const baseUrl = 'live.qareeb-maas.com';
// const baseUrl = 'livetest.qareeb-maas.com';
