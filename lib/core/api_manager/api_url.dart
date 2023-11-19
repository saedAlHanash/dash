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

  static const getDriverById = 'api/services/app/User/Get';

  static const driverRedeems = 'api/services/app/RedeemService/GetRedeems';
  static const allRedeems = 'api/services/app/RedeemService/GetAllRedeems';

  static const carCategories = 'api/services/app/CarCategoriesService/GetAll';

  static const bestDriver = 'api/services/app/User/GetBestDriver';
  static const getAllAdmins = 'api/services/app/User/getAllAdmins';

  static const allRoles = 'api/services/app/Role/GetRoles';

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

  static const buses = 'api/services/app/InstitutionBusesService/GetAll';

  static const superUsers = 'api/services/app/InstitutionSupervisorsService/GetAll';

  static const tempTrips = 'api/services/app/InstitutionTripTemplatesService/GetAll';

  static const tempTripById = 'api/services/app/InstitutionTripTemplatesService/Get';

  static const members = 'api/services/app/InstitutionMembersService/getMembers';

  static const getMemberById = 'api/services/app/InstitutionMembersService/Get';

  static const busTrips = 'api/services/app/InstitutionBusTripsService/GetAllWithData';

  static const busTripById = 'api/services/app/InstitutionBusTripsService/Get';

  static const home = 'api/services/app/InstitutionHomeService/index';
  static const home1 = 'api/services/app/InstitutionHomeService/Get';

  static const subscriptions =
      'api/services/app/InstituionSubscriptionTemplateService/GetAll';

  static const subscriptionById =
      'api/services/app/InstituionSubscriptionTemplateService/Get';

  static const tripHistory = 'api/services/app/InstitutionAttendancesService/GetAll';

  static const allTickets = 'api/services/app/InstitutionTicketsService/GetAll';

  static const getAllSubscriber =
      'api/services/app/InstituionSubscriptionTemplateService/GetAllSubscriper';

  static const memberWithoutSubscription =
      'api/services/app/InstitutionMembersService/getMembersWithoutSubscription';

  static const failedAttendances =
      'api/services/app/InstitutionAttendancesService/GetFaildAttendances';
//GET
//
}

class PostUrl {
  static const requestOtp = 'api/Auth/RequestOTP';
  static const signup = 'api/services/app/Account/Register';
  static const acceptPolicy = 'api/services/app/AcceptPolicy/Create';
  static const serverProxy = 'api/services/app/HttpRequestService/ExecuteRequest';

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

  static const createBus = 'api/services/app/InstitutionBusesService/Create';

  static const createSuperUsers = 'api/services/app/InstitutionSupervisorsService/Create';

  static const createTempTrip = 'api/services/app/InstitutionTripTemplatesService/Create';

  static const createMember = 'api/services/app/InstitutionMembersService/Create';

  static const createSubscription =
      'api/services/app/InstituionSubscriptionTemplateService/Create';
  static const createSubscription1 =
      'api/services/app/InstitutionSubscriptionsService/Create';
  static const createBusTrip = 'api/services/app/InstitutionBusTripsService/Create';

  static const replayTicket =
      'api/services/app/InstitutionTicketsService/AddReplyToTicket';

  static const createSubscriptionFromTemplate =
      'api/services/app/InstitutionSubscriptionsService/CreateFromTemplate';
}

class PutUrl {
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

  static const updateBus = 'api/services/app/InstitutionBusesService/Update';

  static const updateSuperUsers = 'api/services/app/InstitutionSupervisorsService/Update';

  static const updateTempTrip = 'api/services/app/InstitutionTripTemplatesService/Update';

  static const updateMember = 'api/services/app/InstitutionMembersService/Update';

  static const updateSubscription =
      'api/services/app/InstituionSubscriptionTemplateService/Update';
  static const updateSubscription1 =
      'api/services/app/InstitutionSubscriptionsService/Update';

//PUT
//
  static const updateBusTrip = 'api/services/app/InstitutionBusTripsService/Update';
}

class DeleteUrl {
  static const deleteFavoritePlace = 'api/services/app/FavirotePlacesAppServices/Delete';

  static const deleteCancelReason = 'api/services/app/CancelReasons/Delete';
  static const deleteCarCategory = 'api/services/app/CarCategoriesService/Delete';

  static const deleteEdge = 'api/services/app/EdgesService/RemoveEdge';

  static const deletePoint = 'api/services/app/PointsService/Delete';

  static const deleteRole = 'api/services/app/Role/Delete';

  static const deleteInstitution = 'api/services/app/InstitutiosnsService/Delete';

  static const deleteBus = 'api/services/app/InstitutionBusesService/Delete';

  static const deleteSuperUsers = 'api/services/app/InstitutionSupervisorsService/Delete';

  static const deleteTempTrip = 'api/services/app/InstitutionTripTemplatesService/Delete';

  static const deleteBusTrip = 'api/services/app/InstitutionBusTripsService/Delete';

  static const deleteSubscription =
      'api/services/app/InstituionSubscriptionTemplateService/Delete';

  static const deleteMember = 'api/services/app/InstitutionMembersService/Delete';
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

  static const changeLoyalty = 'api/services/app/UserService/ChangeSubscriptionInLoyalty';

  static const changeProviderState =
      'api/services/app/EpaymentService/ChangeActiveStatus';
}

String get baseUrl {
  // final s = AppSharedPreference.isTestMode
  //     ? 'live.qareeb-maas.com'
  //     : 'livetest.qareeb-maas.com';

  return liveUrl;
}

const testUrl = 'qareeb-api.first-pioneers.com.tr';
const liveUrl = 'live.qareeb-maas.com';

/*
POST
api/services/app/InstitutionBusTripsService/Participate

DELETE
api/services/app/InstitutionBusTripsService/DeleteParticipation

GET
api/services/app/InstitutionBusTripsService/GetMemberParticipations


 */
