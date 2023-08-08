class GetUrl {
  static var superUsers = 'api/services/app/InstitutionMembersService/getMembers';
  static const getPolicy = 'api/services/app/Settings/Getsettings';
  static const getReport = 'api/services/app/InstitutionAttendancesService/GetAll';

}

class PostUrl {
  static var createSuperUsers = 'api/services/app/InstitutionSupervisorsService/Create';
  static const loginUrl = 'api/services/app/InstitutionSupervisorsService/Authenticate';
  static const postSingleReport = 'api/services/app/InstitutionAttendancesService/AddAtendance';
  static const postListReport = 'api/services/app/InstitutionAttendancesService/SyncAtendances';



}

class PutUrl {
  static var updateSuperUsers = 'api/services/app/InstitutionSupervisorsService/Update';

}

class DeleteUrl {
  static var deleteSuperUsers = 'api/services/app/InstitutionSupervisorsService/Delete';

}




// const baseUrl = '192.168.1.30:44311';
const baseUrl = 'live.qareeb-maas.com';
