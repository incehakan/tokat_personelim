class Endpoints {
  Endpoints._();

  static const String baseUrl = 'https://personel.karabaglar.bel.tr/Innosa.WA.MPR';
  static const String hospitalUrl = 'https://hbys.izmir.bel.tr/ProbelMobilServiceV2';
  static const String notificationsUrl = 'https://personel.karabaglar.bel.tr/Innosa.WA.MYI';

  // Auth
  static const String token = '/token';
  static const String otp = '/api/mpr/smsGonder';
  static const String forgotPasswordCode = '/api/myi/sifreSifirlamaTalebiGonder';
  static const String changePassword = '/api/myi/sifremiSifirla';

  // Employee
  static const String userInfo = '/api/prs/PersonelBilgileriniGetir';
  static const String employeeMenus = '/api/prs/PersonelMenuleriniGetir';

  // Personal Informations
  static const String debit = '/api/ayn/zimmetler';
  static const String leave = '/api/prs/PersonelIzinBilgileriniGetir';
  static const String salary = '/api/prs/PersonelMaasBilgileri';
  static const String corporateSalary = '/api/prs/KbaglarSirketPersonelBordroGetir';
  static const String payroll = '/api/prs/MemurBordroBilgisiIndir';
  static const String lastEntrance = '/api/prs/PersonelPdksSonGecisBilgileriGetir';
  static const String jobTracking = '/api/mpr/istakipLink';
  static const String driverHours = '/api/ubs/seferBilgileriGetir';
  static const String busLocation = '/api/ubs/otobusSonKonumGetir';
  static const String busRoute = 'api/ubs/hatGuzergahPlanlariniGetir';

  // Corporate Informations
  static const String phoneBooks = '/api/mpr/TelefonRehberi';
  static const String foodList = '/api/mpr/yemekListesiEshot';
  static const String organizationScheme = '/api/mpr/teskilatSemasiIndir';
  static const String subordinates = '/api/prs/PersonelBagBilgileriniGetir';
  static const String subordinateInfo = '/api/prs/SicilBilgileriniGetir';
  static const String subordinateLeaveInfo = '/api/prs/PersonelIzinBilgisiGetir';
  static const String subordinatePdksInfo = '/api/prs/PdksSicilTumBilgileri';
  static const String queryWithBarcode = '/api/ayn/demirbasBul';
  static const String queryWithSerialNo = '/api/ayn/demirbas';
  static const String fixtureUnit = '/api/ayn/ambarBilgileri';
  static const String services = '/api/ayn/servisler/ambar/';
  static const String rooms = '/api/ayn/odalar';
  static const String movable = '/api/ayn/tasinirBilgileri';
  static const String addMovable = '/api/ayn/sayim/detay';
  static const String movableCounts = '/api/ayn/sayim';
  static const String accidentReports = '/api/mpr/ramakBilgileriniGetir';
  static const String newAccident = '/api/mpr/ramakBilgisi';
  static const String requestAndComplaint = '/api/prs/IstekSikayetOneriGonder';

  // Appointment
  static const String relatives = '/api/prs/personelakrababilgilerinigetir';
  static const String patientInformation = '/api/hasta_bilgisi';
  static const String earlyRegistration = '/api/erken_kayit_kontrol';
  static const String kiosks = '/api/kiosk_servis_listesi';
  static const String appointments = '/api/randevu_bilgileri_ileri';
  static const String cancelAppointment = '/api/randevu_iptal_ileri';
  static const String serviceAcceptanceControl = '/api/hasta_servis_kabul_kontrol';
  static const String patientAcceptanceControl = '/api/hasta_kabul_kontrol';
  static const String patientAppointment = '/api/gelis_bilgisi';
  static const String labResults = '/api/labBilgi';
  static const String labResultDetail = '/api/labSonuc';
  static const String patResults = '/api/patBilgi';
  static const String patResultDetail = '/api/patSonuc';
  static const String viewResult = '/api/radBilgi';
  static const String makeAppointment = '/api/yeni_girisi';
  static const String createUser = '/api/myi/kullaniciTalebiGonder';
  static const String createUserConfirm = '/api/myi/kullaniciTalebiOnayla';

  // Notifications vb.
  static const String feeds = '/api/myi/gönderiListeleri';
  static const String birthdays = '/api/mpr/akislar';
  static const String celebrateBirthday = '/api/mpr/etkilesim';
  static const String birthdayCelebrations = '/api/mpr/tümEtkilesimlerimiGetir';
  static const String notificationHistory = '/api/myi/bildirimgecmisi';
  static const String activePopUp = '/api/myi/AktifPopupGetir';

  // PDKS
  static const String confirmationDocument = '/api/mpr/belgeBilgisiGetir?belgeKodu=XYGUSKCJGQ';
  static const String confirmDocument = '/api/mpr/belgeBilgisiOnayla';
  // fetchpdksdevicelocations
  static const String pdksLocations = '/api/prs/PersonelPdksUygunLokasyonGetir';
  static const String pdksOperation = '/api/prs/PersonelPdksGecisBilgisiKaydet';
  // fetchpdksduties
  static const String pdksDutyLocation = '/api/prs/PersonelPdksGorevLokasyonGetir';
  static const String pdksInformations = '/api/prs/PdksTumBilgileri';
  static const String pdksNearbyDevices = '/api/prs/PersonelPdksYakinLokasyonGetir';
}
