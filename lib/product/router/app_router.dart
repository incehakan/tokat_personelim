import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:tokatpersonelim/features/data/repository/cache_repository.dart';
import 'package:tokatpersonelim/features/presentation/notifications/feed_screen.dart';
import 'package:tokatpersonelim/features/presentation/notifications/tab_screens/notifications/notifications_screen.dart';

import '../../features/data/models/subordinates_model.dart';
import '../../features/presentation/accident/accident_screen.dart';
import '../../features/presentation/appointment/appointment_detail_screen.dart';
import '../../features/presentation/appointment/appointment_screen.dart';
import '../../features/presentation/appointment/tab_screens/results/lab_results/lab_result_detail_screen.dart';
import '../../features/presentation/appointment/tab_screens/results/lab_results/lab_results_screen.dart';
import '../../features/presentation/appointment/tab_screens/results/pat_results/pat_result_detail_screen.dart';
import '../../features/presentation/appointment/tab_screens/results/pat_results/pat_results_screen.dart';
import '../../features/presentation/appointment/tab_screens/results/view_results/view_result_detail_screen.dart';
import '../../features/presentation/appointment/tab_screens/results/view_results/view_results_screen.dart';
import '../../features/presentation/auth/create_user/create_user_screen.dart';
import '../../features/presentation/auth/forgot_password/change_password_screen.dart';
import '../../features/presentation/auth/login/login_screen.dart';
import '../../features/presentation/auth/otp_code/otp_code_screen.dart';
import '../../features/presentation/bus_schedule_information/bus_location/bus_location_screen.dart';
import '../../features/presentation/bus_schedule_information/bus_route/bus_route_screen.dart';
import '../../features/presentation/bus_schedule_information/driver_hours/driver_hours_screen.dart';
import '../../features/presentation/cloud_izmir/cloud_izmir_screen.dart';
import '../../features/presentation/corporate_mail/corporate_mail_screen.dart';
import '../../features/presentation/debit/debit_screen.dart';
import '../../features/presentation/employee_info/employee_info_detail/employee_info_detail_screen.dart';
import '../../features/presentation/employee_info/employee_info_screen.dart';
import '../../features/presentation/entrance/confirmation_screen.dart';
import '../../features/presentation/entrance/faq_screen.dart';
import '../../features/presentation/entrance/nearby_devices_screen.dart';
import '../../features/presentation/entrance/operations/entrance_operations_screen.dart';
import '../../features/presentation/food_list/food_list_screen.dart';

import '../../features/presentation/ibb_academy/ibb_academy_screen.dart';
import '../../features/presentation/job_tracking/job_tracking_screen.dart';
import '../../features/presentation/leave/leaves_screen.dart';
import '../../features/presentation/main/drawer/activities_screen.dart';
import '../../features/presentation/main/drawer/history_screen.dart';
import '../../features/presentation/main/drawer/legislation_screen.dart';
import '../../features/presentation/main/drawer/units_screen.dart';
import '../../features/presentation/main/drawer/vision_screen.dart';
import '../../features/presentation/main/main_screen.dart';
import '../../features/presentation/movable/movable_info_screen.dart';
import '../../features/presentation/movable/tab_screens/fixture/fixture_units_screen.dart';
import '../../features/presentation/movable_count/first_screen/movable_count_fixture_units_screen.dart';
import '../../features/presentation/movable_count/first_screen/movable_count_rooms_screen.dart';
import '../../features/presentation/movable_count/first_screen/movable_count_services_screen.dart';
import '../../features/presentation/movable_count/movable_count_screen.dart';
import '../../features/presentation/movable_count/second_screen/movable_count_movables_screen.dart';
import '../../features/presentation/notifications/firebase_notification_detail_screen.dart';
import '../../features/presentation/onboarding/onboarding_screen.dart';
import '../../features/presentation/organization_scheme/organization_scheme_screen.dart';
import '../../features/presentation/pdks/pdks_information_screen.dart';
import '../../features/presentation/pergel_izmir/pergel_izmir_screen.dart';
import '../../features/presentation/phone_book/phone_book_screen.dart';
import '../../features/presentation/request_and_complaint/request_and_complaint_screen.dart';
import '../../features/presentation/salary/corporate_payroll_screen.dart';
import '../../features/presentation/salary/corporate_salary_screen.dart';
import '../../features/presentation/salary/payroll_screen.dart';
import '../../features/presentation/salary/salary_screen.dart';
import 'app_routes.dart';

GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.path(AppRoutes.login),
      name: AppRoutes.login,
      builder: (_, __) => const LoginScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.otpCode,
          name: AppRoutes.otpCode,
          builder: (_, state) {
            if (kDebugMode) {
              print("username: ${CacheRepository.getUsername()}");
              print("password: ${CacheRepository.getPassword()}");
            }

            final String otpCode = state.extra as String;

            return OtpCodeScreen(otpCode: otpCode);
          },
        ),
        /* <  GoRoute(
          path: AppRoutes.otpCode,
          name: AppRoutes.otpCode,
          builder: (_, state) {
            final String otpCode = state.extra as String;
            return OtpCodeScreen(otpCode: otpCode);
          },
        ),> */
        GoRoute(
          path: AppRoutes.changePassword,
          name: AppRoutes.changePassword,
          builder: (_, state) {
            final List<String> values = state.extra as List<String>;
            return ChangePasswordScreen(
              identity: values.first,
              username: values.last,
            );
          },
        ),
        GoRoute(
          path: AppRoutes.createUser,
          name: AppRoutes.createUser,
          builder: (_, state) {
            final String identity = state.extra as String;
            return CreateUserScreen(identity: identity);
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.path(AppRoutes.main),
      name: AppRoutes.main,
      builder: (_, __) => const MainScreen(),
      routes: [
        GoRoute(
          path: AppRoutes.notifications,
          name: AppRoutes.notifications,
          builder: (_, state) {
            return const NotificationsScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.firebaseNotification,
          name: AppRoutes.firebaseNotification,
          builder: (_, state) {
            final RemoteMessage message = state.extra as RemoteMessage;
            return FirebaseNotificationDetailScreen(message: message);
          },
        ),
        GoRoute(
          path: AppRoutes.feed,
          name: AppRoutes.feed,
          builder: (_, __) => const FeedScreen(),
        ),
        GoRoute(
          path: AppRoutes.activities,
          name: AppRoutes.activities,
          builder: (_, __) => const ActivitiesScreen(),
        ),
        GoRoute(
          path: AppRoutes.history,
          name: AppRoutes.history,
          builder: (_, __) => const HistoryScreen(),
        ),
        GoRoute(
          path: AppRoutes.legislation,
          name: AppRoutes.legislation,
          builder: (_, __) => const LegislationScreen(),
        ),
        GoRoute(
          path: AppRoutes.units,
          name: AppRoutes.units,
          builder: (_, __) => const UnitsScreen(),
        ),
        GoRoute(
          path: AppRoutes.vision,
          name: AppRoutes.vision,
          builder: (_, __) => const VisionScreen(),
        ),
        GoRoute(
          path: AppRoutes.debit,
          name: AppRoutes.debit,
          builder: (_, __) => const DebitScreen(),
        ),
        GoRoute(
          path: AppRoutes.leave,
          name: AppRoutes.leave,
          builder: (_, __) => const LeaveInformationScreen(),
        ),
        GoRoute(
          path: AppRoutes.salary,
          name: AppRoutes.salary,
          builder: (_, __) => const SalaryScreen(),
        ),
        GoRoute(
          path: AppRoutes.corporateSalary,
          name: AppRoutes.corporateSalary,
          builder: (_, __) => const CorporateSalaryScreen(),
        ),
        GoRoute(
          path: AppRoutes.payroll,
          name: AppRoutes.payroll,
          builder: (_, state) {
            final String payrollUrl = state.extra as String;
            return PayrollScreen(payrollUrl: payrollUrl);
          },
        ),
        GoRoute(
          path: AppRoutes.corporatePayroll,
          name: AppRoutes.corporatePayroll,
          builder: (_, state) {
            return const CorporatePayrollScreen();
          },
        ),
        GoRoute(
          path: AppRoutes.entrance,
          name: AppRoutes.entrance,
          builder: (_, __) => const EntranceOperationsScreen(),
        ),
        GoRoute(
          path: AppRoutes.jobTracking,
          name: AppRoutes.jobTracking,
          builder: (_, __) => const JobTrackingScreen(),
        ),
        GoRoute(
          path: AppRoutes.appointment,
          name: AppRoutes.appointment,
          builder: (_, __) => const AppointmentScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.appointmentDetail,
              name: AppRoutes.appointmentDetail,
              builder: (_, __) => const AppointmentDetailScreen(),
              routes: [
                GoRoute(
                  path: AppRoutes.labResult,
                  name: AppRoutes.labResult,
                  builder: (_, __) => const LabResultsScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.labResultDetail,
                      name: AppRoutes.labResultDetail,
                      builder: (_, state) {
                        final protocolNo = state.extra as String;
                        return LabResultDetailScreen(
                          protocolNo: protocolNo,
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: AppRoutes.patResult,
                  name: AppRoutes.patResult,
                  builder: (_, __) => const PatResultsScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.patResultDetail,
                      name: AppRoutes.patResultDetail,
                      builder: (_, state) {
                        final pathologyId = state.extra as String;
                        return PatResultDetailScreen(
                          pathologyId: pathologyId,
                        );
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: AppRoutes.viewResult,
                  name: AppRoutes.viewResult,
                  builder: (_, __) => const ViewResultsScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoutes.viewResultDetail,
                      name: AppRoutes.viewResultDetail,
                      builder: (_, state) {
                        final result = state.extra as String;
                        return ViewResultDetailScreen(
                          result: result,
                        );
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        GoRoute(
          path: AppRoutes.driverHours,
          name: AppRoutes.driverHours,
          builder: (_, __) => const DriverHoursScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.busLocation,
              name: AppRoutes.busLocation,
              builder: (_, state) {
                final busPlate = state.extra as String;
                return BusLocationScreen(
                  busPlate: busPlate,
                );
              },
            ),
            GoRoute(
              path: AppRoutes.busRoute,
              name: AppRoutes.busRoute,
              builder: (_, state) {
                final routeNo = state.extra as String;
                return BusRouteScreen(
                  routeNo: routeNo,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.phoneBook,
          name: AppRoutes.phoneBook,
          builder: (_, __) => const PhoneBookScreen(),
        ),
        GoRoute(
          path: AppRoutes.foodList,
          name: AppRoutes.foodList,
          builder: (_, __) => const FoodListScreen(),
        ),
        GoRoute(
          path: AppRoutes.organizationScheme,
          name: AppRoutes.organizationScheme,
          builder: (_, __) => const OrganizationSchemeScreen(),
        ),
        GoRoute(
          path: AppRoutes.cloudIzmir,
          name: AppRoutes.cloudIzmir,
          builder: (_, __) => const CloudIzmirScreen(),
        ),
        GoRoute(
          path: AppRoutes.pergelIzmir,
          name: AppRoutes.pergelIzmir,
          builder: (_, __) => const PergelIzmirScreen(),
        ),
        GoRoute(
          path: AppRoutes.corporateMail,
          name: AppRoutes.corporateMail,
          builder: (_, __) => const CorporateMailScreen(),
        ),
        GoRoute(
          path: AppRoutes.ibbAcademy,
          name: AppRoutes.ibbAcademy,
          builder: (_, __) => const AcademyScreen(),
        ),
        GoRoute(
          path: AppRoutes.employeeInfo,
          name: AppRoutes.employeeInfo,
          builder: (_, __) => const EmployeeInfoScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.employeeInfoDetail,
              name: AppRoutes.employeeInfoDetail,
              builder: (_, state) {
                final subordinate = state.extra as Subordinate;
                return EmployeeInfoDetailScreen(
                  subordinate: subordinate,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.accident,
          name: AppRoutes.accident,
          builder: (_, __) => const AccidentScreen(),
        ),
        GoRoute(
          path: AppRoutes.movableCount,
          name: AppRoutes.movableCount,
          builder: (_, __) => const MovableCountScreen(),
          routes: [
            GoRoute(
              path: AppRoutes.movableCountFixtureUnit,
              name: AppRoutes.movableCountFixtureUnit,
              builder: (_, __) => const MovableCountFixtureUnitsScreen(),
            ),
            GoRoute(
              path: AppRoutes.movableCountServices,
              name: AppRoutes.movableCountServices,
              builder: (_, __) => const MovableCountServicesScreen(),
            ),
            GoRoute(
              path: AppRoutes.movableCountRooms,
              name: AppRoutes.movableCountRooms,
              builder: (_, __) => const MovableCountRoomsScreen(),
            ),
            GoRoute(
              path: AppRoutes.movableCountMovables,
              name: AppRoutes.movableCountMovables,
              builder: (_, __) => const MovableCountMovablesScreen(),
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.movableInfo,
          name: AppRoutes.movableInfo,
          builder: (_, __) => const MovableInfoScreen(),
        ),
        GoRoute(
          path: AppRoutes.fixtureUnits,
          name: AppRoutes.fixtureUnits,
          builder: (_, __) => const FixtureUnitsScreen(),
        ),
        GoRoute(
          path: AppRoutes.pdksConfirmation,
          name: AppRoutes.pdksConfirmation,
          builder: (_, __) => const PdksConfirmationScreen(),
        ),
        GoRoute(
          path: AppRoutes.pdksInformation,
          name: AppRoutes.pdksInformation,
          builder: (_, __) => const PdksInformationScreen(),
        ),
        GoRoute(
          path: AppRoutes.pdksFaq,
          name: AppRoutes.pdksFaq,
          builder: (_, __) => const PdksFaqScreen(),
        ),
        GoRoute(
          path: AppRoutes.pdksNearbyDevices,
          name: AppRoutes.pdksNearbyDevices,
          builder: (_, __) => const PdksNearbyDevicesScreen(),
        ),
        GoRoute(
          path: AppRoutes.requestAndComplaint,
          name: AppRoutes.requestAndComplaint,
          builder: (_, __) => const RequestAndComplaintScreen(),
        ),
      ],
    ),
  ],
);
