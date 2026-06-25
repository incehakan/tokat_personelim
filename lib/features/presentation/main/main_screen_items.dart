part of 'main_screen.dart';

List<String> drawerTitles = [
  "E-Belediye",
  "Yönetim Şeması",
  AppStrings.vision,
  "Raporlar",
  AppStrings.units,
];

List<IconData> drawerIcons = [
  Icons.library_books,
  Icons.file_copy,
  Icons.tab,
  Icons.work,
  Icons.table_view,
];

List<String> drawerRoutes = [
  AppRoutes.history,
  AppRoutes.organizationScheme,
  AppRoutes.vision,
  AppRoutes.activities,
  AppRoutes.units,
];

List<String> navbarLabels = [
  AppStrings.home,
  AppStrings.profile,
];

List<IconData> navbarIcons = [
  Ionicons.home,
  Ionicons.person,
];

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    Key? key,
    required this.text,
    required this.icon,
    required this.route,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed(route),
      tileColor: Theme.of(context).primaryColor,
      leading: Icon(icon, color: Colors.white),
      title: Text(text),
      titleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
          ),
      shape: const RoundedRectangleBorder(
        borderRadius: AppDimensions.cardRadius,
      ),
    );
  }
}
