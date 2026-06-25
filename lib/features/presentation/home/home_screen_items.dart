part of 'home_screen.dart';

//

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key? key,
    required this.menu,
    required this.infoType,
    required this.route,
  }) : super(key: key);

  final MenuItem menu;
  final InfoType infoType;
  final String route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final personelType = CacheRepository.userInfo().personelTypeName;
        if (route == "salary" && personelType == "ŞİRKET PERSONELİ") {
          context.pushNamed(AppRoutes.corporateSalary);
        } else {
          context.pushNamed(route);
        }
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: AppDimensions.cardRadius,
          color: infoType == InfoType.personal ? Theme.of(context).primaryColor : AppColors.lynch,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              menu.icon?.startsWith('http') == true
                  ? menu.icon!
                  : Endpoints.baseUrl + (menu.icon ?? ''),
              fit: BoxFit.contain,
              height: 30,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.apps,
                  color: Colors.white,
                  size: 30,
                );
              },
            ),
            Center(
              child: Text(
                menu.menuName!.replaceFirst(" ", "\n"),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
