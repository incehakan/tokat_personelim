import '../../features/data/models/menu_model.dart';
import '../router/app_routes.dart';

/// `MenuItem`'in [menuUrl] adlı değişkenine göre routeları belirleyen extension.
/// Her kullanıcının her menüyü görmesi istenmediği için bu tarz bir yaklaşım
/// izlenmiştir.
extension MenuRouteExtension on MenuItem {
  String get route {
    switch (menuUrl) {
      case "PermissionScreen()":
        return AppRoutes.leave;
      case "SalaryScreen()":
        return AppRoutes.salary;
      case "DebitScreen()":
        return AppRoutes.debit;
      case "PhoneBook()":
        return AppRoutes.phoneBook;
      case "MovableInfo()":
        return AppRoutes.movableInfo;
      case "IzbbPop()":
        return AppRoutes.ibbAcademy;
      case "organizationScheme()":
        return AppRoutes.organizationScheme;
      case "FoodList()":
        return AppRoutes.foodList;
      case "jobTracking()":
        return AppRoutes.jobTracking;
      case "EsrefpasaAppo()":
        return AppRoutes.appointment;
      case "pergelPop()":
        return AppRoutes.pergelIzmir;
      case "WebMailPop()":
        return AppRoutes.corporateMail;
      case "cloudPop()":
        return AppRoutes.cloudIzmir;
      case "PersonelTakipPop()":
        return AppRoutes.employeeInfo;
      case "ramakPop()":
        return AppRoutes.accident;
      case "sikayetPop()":
        return AppRoutes.requestAndComplaint;
      case "sayimPop()":
        return AppRoutes.movableCount;
      case "pdksBilPop()":
        return AppRoutes.pdksInformation;
      case "SeferBilgileriPop()":
        return AppRoutes.driverHours;
      case "PDKSInfo()":
        return AppRoutes.pdksConfirmation;

      default:
        return AppRoutes.main;
    }
  }
}
