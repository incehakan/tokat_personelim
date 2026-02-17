class AppRoutes {
  AppRoutes._();

  static String path(String route) {
    return '/$route';
  }

  // Auth
  static const String login = 'login';
  static const String changePassword = 'change_password';
  static const String otpCode = 'otp_code';
  static const String firebaseNotification = 'firebase_notification';

  // Home
  static const String main = 'main';
  static const String debit = 'debit';
  static const String leave = 'leave';
  static const String salary = 'salary';
  static const String corporateSalary = 'corporate_salary';
  static const String payroll = 'payroll';
  static const String corporatePayroll = 'corporate_payroll';
  static const String entrance = 'entrance';
  static const String jobTracking = 'job_tracking';
  static const String appointment = 'appointment';
  static const String appointmentDetail = 'appointment_detail';
  static const String driverHours = 'driver_hours';
  static const String feed = 'feed';
  static const String phoneBook = 'phone_book';
  static const String foodList = 'food_list';
  static const String organizationScheme = 'organization_scheme';
  static const String cloudIzmir = 'cloud_izmir';
  static const String pergelIzmir = 'pergel_izmir';
  static const String corporateMail = 'corporate_mail';
  static const String ibbAcademy = 'ibb_academy';
  static const String employeeInfo = 'employee_info';
  static const String employeeInfoDetail = 'employee_info_detail';
  static const String busLocation = 'bus_location';
  static const String busRoute = 'bus_route';
  static const String movableInfo = 'movable_info';
  static const String fixtureUnits = 'fixture_units';
  static const String pdksConfirmation = 'pdks_confirmation';
  static const String pdksInformation = 'pdks_information';
  static const String pdksFaq = 'pkds_faq';
  static const String pdksNearbyDevices = 'pdks_nearby_devices';
  static const String notifications = 'notifications';
  static const String createUser = 'create_user';
  static const String notificationDetail = 'notification_detail';
  static const String movableCount = 'movable_count';
  static const String movableCountFixtureUnit = 'movable_count_fixture_unit';
  static const String movableCountServices = 'movable_count_services';
  static const String movableCountRooms = 'movable_count_rooms';
  static const String movableCountMovables = 'movable_count_movables';
  static const String accident = 'accident';
  static const String requestAndComplaint = 'request_and_complaint';

  // Drawer
  static const String activities = 'activities';
  static const String history = 'history';
  static const String legislation = 'legislation';
  static const String units = 'units';
  static const String vision = 'vision';

  // Hospital
  static const String labResult = 'lab_result';
  static const String labResultDetail = 'lab_result_detail';
  static const String patResult = 'pat_result';
  static const String patResultDetail = 'pat_result_detail';
  static const String viewResult = 'view_result';
  static const String viewResultDetail = 'view_result_detail';
}
