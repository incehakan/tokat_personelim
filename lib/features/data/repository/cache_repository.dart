import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../../../product/constants/hive_constants.dart';
import '../models/user_info_model.dart';

class CacheRepository {
  CacheRepository._();

  static final _tokenBox = Hive.box(HiveConstants.token);
  static final _phoneVerificationBox = Hive.box(HiveConstants.phoneVerification);
  static final _userCredentialsBox = Hive.box(HiveConstants.userCredentials);
  static final _userBox = Hive.box(HiveConstants.user);
  static final _hospitalBox = Hive.box(HiveConstants.hospital);

  static Future<void> openAllBoxes() async {
    await Hive.openBox(HiveConstants.token);
    await Hive.openBox(HiveConstants.phoneVerification);
    await Hive.openBox(HiveConstants.userCredentials);
    await Hive.openBox(HiveConstants.hospital);
    Hive.registerAdapter(UserInfoAdapter());
    await Hive.openBox(HiveConstants.user);
  }

  static void logout() {
    _tokenBox.clear();
    _userCredentialsBox.clear();
    _phoneVerificationBox.clear();
    _userBox.clear();
  }

  static void setToken(String? accessToken, String? refreshToken) {
    _tokenBox.put(HiveConstants.accessToken, accessToken);
    _tokenBox.put(HiveConstants.refreshToken, refreshToken);
  }

  static String? getAccessToken() {
    final token = _tokenBox.get(HiveConstants.accessToken);
    if (kDebugMode) {
      print(token);
    }
    return token;
  }

  static String? getRefreshToken() {
    final token = _tokenBox.get(HiveConstants.refreshToken);
    if (kDebugMode) {
      print(token);
    }
    return token;
  }

  static verificatePhone() {
    _phoneVerificationBox.put(HiveConstants.phoneVerification, true);
  }

  static bool isPhoneVerificated() {
    return _phoneVerificationBox.get(HiveConstants.phoneVerification) ?? false;
  }

  static void setUserCredentials(String username, String password) {
    _userCredentialsBox.put(HiveConstants.username, username);
    _userCredentialsBox.put(HiveConstants.password, password);
  }

  static String? getUsername() {
    return _userCredentialsBox.get(HiveConstants.username) as String?;
  }

  static String? getPassword() {
    return _userCredentialsBox.get(HiveConstants.password) as String?;
  }

  static void saveUserInfo(UserInfo user) {
    _userBox.put(HiveConstants.user, user);
  }

  static UserInfo userInfo() {
    final employee = _userBox.get(HiveConstants.user);
    return employee;
  }

  static void setHospitalToken(String token) {
    _hospitalBox.put(HiveConstants.token, token);
  }

  static String getHospitalToken() {
    final token = _hospitalBox.get(HiveConstants.token);
    return token;
  }

  static void setPatientRegistryNo(String registryNo) {
    _hospitalBox.put(HiveConstants.patientRegistry, registryNo);
  }

  static String getPatientRegistryNo() {
    final registryNo = _hospitalBox.get(HiveConstants.patientRegistry);
    if (kDebugMode) {
      print(registryNo);
    }
    return registryNo;
  }

  static void setPatientNo(String patientNo) {
    _hospitalBox.put(HiveConstants.patientNo, patientNo);
  }

  static String getPatientNo() {
    final patientNo = _hospitalBox.get(HiveConstants.patientNo);
    if (kDebugMode) {
      print(patientNo);
    }
    return patientNo;
  }
}
