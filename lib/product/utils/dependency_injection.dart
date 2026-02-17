import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/data/repository/auth_repository.dart';
import '../../features/data/repository/corporate_repository.dart';
import '../../features/data/repository/employee_repository.dart';
import '../../features/data/repository/hospital_repository.dart';
import '../../features/data/repository/notification_repository.dart';
import '../../features/data/repository/pdks_repository.dart';
import '../../features/presentation/accident/cubit/accident_cubit.dart';
import '../../features/presentation/appointment/cubit/hospital_token_cubit.dart';
import '../../features/presentation/appointment/cubit/relative_cubit.dart';
import '../../features/presentation/appointment/tab_screens/appointments/cubit/appointments_cubit.dart';
import '../../features/presentation/appointment/tab_screens/make_appointment/cubit/make_appointment_cubit.dart';
import '../../features/presentation/appointment/tab_screens/results/lab_results/cubit/lab_result_details_cubit.dart';
import '../../features/presentation/appointment/tab_screens/results/lab_results/cubit/lab_results_cubit.dart';
import '../../features/presentation/appointment/tab_screens/results/pat_results/cubit/pat_result_detail_cubit.dart';
import '../../features/presentation/appointment/tab_screens/results/pat_results/cubit/pat_results_cubit.dart';
import '../../features/presentation/appointment/tab_screens/results/view_results/cubit/view_results_cubit.dart';
import '../../features/presentation/auth/create_user/cubit/create_user_cubit.dart';
import '../../features/presentation/auth/forgot_password/cubit/change_password_cubit.dart';
import '../../features/presentation/auth/login/cubit/login_cubit.dart';
import '../../features/presentation/employee_info/cubit/subordinates_cubit.dart';
import '../../features/presentation/employee_info/employee_info_detail/tab_screens/subordinate_info/cubit/subordinate_info_cubit.dart';
import '../../features/presentation/employee_info/employee_info_detail/tab_screens/subordinate_leave_info/cubit/subordinate_leave_info_cubit.dart';
import '../../features/presentation/employee_info/employee_info_detail/tab_screens/subordinate_pdks_info/cubit/subordinate_pdks_info_cubit.dart';
import '../../features/presentation/entrance/cubit/confirmation_document_cubit.dart';
import '../../features/presentation/entrance/cubit/entrance_cubit.dart';
import '../../features/presentation/entrance/cubit/nearby_devices_cubit.dart';
import '../../features/presentation/notifications/tab_screens/birthday/cubit/birthday_cubit.dart';
import '../../features/presentation/notifications/tab_screens/flow/cubit/flows_cubit.dart';
import '../../features/presentation/notifications/tab_screens/notifications/cubit/notification_history_cubit.dart';
import '../../features/presentation/food_list/cubit/food_list_cubit.dart';

import '../../features/presentation/movable/tab_screens/barcode/cubit/query_with_barcode_cubit.dart';
import '../../features/presentation/movable/tab_screens/fixture/cubit/fixture_cubit.dart';
import '../../features/presentation/movable/tab_screens/serial_number/cubit/query_with_serial_number_cubit.dart';
import '../../features/presentation/movable_count/cubit/movable_count_cubit.dart';
import '../../features/presentation/pdks/cubit/pdks_info_cubit.dart';
import '../../features/presentation/phone_book/cubit/phone_book_cubit.dart';
import 'network_manager.dart';

final getIt = GetIt.instance;

void setDI() {
  getIt.registerLazySingleton(
    () => AuthRepository(
      Dio(),
      NetworkManager(
        Dio(),
      ),
    ),
  );
  getIt.registerFactory(
    () => LoginCubit(
      AuthRepository(
        Dio(),
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => EntranceCubit(
      PdksRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => RelativeCubit(
      HospitalRepository(
        NetworkManager(
          Dio(),
        ),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => HospitalTokenCubit(
      HospitalRepository(
        NetworkManager(
          Dio(),
        ),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => AppointmentsCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => LabResultsCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => LabResultDetailsCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => PatResultsCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => PatResultDetailCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => ViewResultsCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => MakeAppointmentCubit(
      HospitalRepository(
        NetworkManager(Dio()),
        Dio(),
        HospitalNetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => FlowsCubit(
      NotificationRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => BirthdayCubit(
      NotificationRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => NotificationHistoryCubit(
      NotificationRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => PhoneBookCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => FoodListCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => SubordinatesCubit(
      EmployeeRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => SubordinateInfoCubit(
      EmployeeRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => SubordinateLeaveInfoCubit(
      EmployeeRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => SubordinatePdksInfoCubit(
      EmployeeRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => HospitalRepository(
      NetworkManager(Dio()),
      Dio(),
      HospitalNetworkManager(
        Dio(),
      ),
    ),
  );

  getIt.registerFactory(
    () => QueryWithBarcodeCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => QueryWithSerialNumberCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => FixtureCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => PdksInfoCubit(
      PdksRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => NearbyDevicesCubit(
      PdksRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => ConfirmationDocumentCubit(
      PdksRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => ChangePasswordCubit(
      AuthRepository(
        Dio(),
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => CreateUserCubit(
      AuthRepository(
        Dio(),
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => NotificationRepository(
      NetworkManager(
        Dio(),
      ),
    ),
  );

  getIt.registerFactory(
    () => MovableCountCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );

  getIt.registerFactory(
    () => AccidentCubit(
      CorporateRepository(
        NetworkManager(
          Dio(),
        ),
      ),
    ),
  );
  getIt.registerFactory(
    () => CorporateRepository(
      NetworkManager(
        Dio(),
      ),
    ),
  );
}
