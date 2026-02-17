part of 'appointment_detail_screen.dart';

final List<String> tabTitles = [
  AppStrings.makeAppointment,
  AppStrings.myAppointments,
  AppStrings.myResults,
];

final List<IconData> tabIcons = [
  Ionicons.reader_outline,
  Ionicons.calendar_outline,
  Ionicons.flask_outline,
];

const List<Widget> tabPages = [
  MakeAppointmentScreen(),
  AppointmentsScreen(),
  ResultsScreen(),
];

class AppointmentTabBar extends StatelessWidget {
  const AppointmentTabBar({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return GNav(
      rippleColor: Colors.grey.shade800,
      hoverColor: Colors.grey.shade700,
      haptic: true,
      tabBorderRadius: 15,
      tabActiveBorder: Border.all(color: AppColors.lynch, width: 0.5),
      curve: Curves.easeOutExpo,
      duration: const Duration(milliseconds: 300),
      gap: 8,
      color: Colors.grey[800],
      activeColor: Colors.white,
      iconSize: 24,
      tabBackgroundColor: AppColors.kashmirBlue,
      padding: const EdgeInsets.all(AppDimensions.smallGap),
      tabs: List.generate(
        tabTitles.length,
        (index) => GButton(
          icon: tabIcons[index],
          text: tabTitles[index],
        ),
      ),
      onTabChange: (index) {
        pageController.jumpToPage(index);
      },
      mainAxisAlignment: MainAxisAlignment.spaceAround,
    );
  }
}
